// 1. Install necessary dependencies
import express from "express";
import bodyParser from "body-parser";
import ejs from "ejs";
import cookieParser from "cookie-parser";
import jwt from "jsonwebtoken";
import { checkCredentials, getCDetails, getCusId, getEDetails, createCurrent, createSavings } from "./database/database.js";
import { getSavTypeDetails } from "./database/database.js";
import { getSavingsDetails } from "./database/database.js";
import { validateSavingsAccount } from "./database/database.js";
import { validateTransferAmount } from "./database/database.js";
import { getCurrentDetails } from "./database/database.js";
import { authenticateAdminToken, authenticateUserToken } from "./auth.js"

// Set up the express app
const app = express();
app.set("view engine", "ejs");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static("public"));
app.use(cookieParser());

////////////////////////////////////////////////////////////////////////////
//authentication + dashboard

// let isAuthenticated = false;
app.get("/", (req, res) => {
  res.render("login");
});

//basic details
let userId = "";
let name = "";
let user_type = "";

app.post("/dashboard", async (req, res) => {
  const userName = req.body.username;
  const pw = req.body.password;

  await checkCredentials(userName, pw).then(async (result) => {
    if (result) {
      userId = result[0].user_id;
      user_type = result[0].user_type;

      //authorization
      const token = jwt.sign(
        { un: userName, role: "user" },
        "jwt_User_privateKey",  ///this is a password ///////////
        { expiresIn: "5m" }
      );
      console.log(token);

      res.cookie("jwt", token, { httpOnly: true }); // Token will expire in 20 min (1200000 ms)

      if (user_type == "customer") {

        let cDet = await getCDetails(userId);
        let sDet =  await getSavingsDetails(userId);
        let cuDet=  await getCurrentDetails(userId);

        let savingsAccountNo;
        let savingsAccountBalance;
        let withdrawalsLeft;
        let currentAccountNo; 
        let currentAccountBalance;

        if (sDet != undefined) {
          savingsAccountNo = sDet.account_no;
          savingsAccountBalance = sDet.balance;
          withdrawalsLeft = sDet.remaining_withdrawals;
        }
        if (cuDet != undefined) {
          currentAccountNo = cuDet.account_no;
          currentAccountBalance = cuDet.balance;
        }

        res.render("dashboard", {
          "name": cDet.name,
          "savingsAccountNo": savingsAccountNo,
          "savingsAccountBalance": savingsAccountBalance,
          "withdrawalsLeft": withdrawalsLeft,
          "currentAccountNo": currentAccountNo,
          "currentAccountBalance": currentAccountBalance
      });
     

      }else if (user_type == "employee") {

        let eDet = await getEDetails(userId);

        res.render("employeeDash", {
          "name": eDet.name
        });     
      }
    } else {
      res.redirect("/");
    }
  });
});

app.get("/dashboard", authenticateUserToken, async (req, res) => {
  // if (isAuthenticated) {

    if (user_type == "customer") {

      let cDet = await getCDetails(userId);
      let sDet =  await getSavingsDetails(userId);
      let cuDet=  await getCurrentDetails(userId);
  
      let savingsAccountNo;
      let savingsAccountBalance;
      let withdrawalsLeft;
      let currentAccountNo; 
      let currentAccountBalance;
  
      if (sDet != undefined) {
        savingsAccountNo = sDet.account_no;
        savingsAccountBalance = sDet.balance;
        withdrawalsLeft = sDet.remaining_withdrawals;
      }
      if (cuDet != undefined) {
        currentAccountNo = cuDet.account_no;
        currentAccountBalance = cuDet.balance;
      }

        res.render("dashboard", {
          "name": cDet.name,
          "savingsAccountNo": savingsAccountNo,
          "savingsAccountBalance": savingsAccountBalance,
          "withdrawalsLeft": withdrawalsLeft,
          "currentAccountNo": currentAccountNo,
          "currentAccountBalance": currentAccountBalance
        }); 
    }else if (user_type == "employee") {
      let eDet = await getEDetails(userId);

      res.render("employeeDash.ejs", {
        "name": eDet.name,  

      });
    }

});

////////////////////////////////////////////////////////////////////////////
//savings for customer view
app.get("/savings", authenticateUserToken , async (req, res) => {

  let cDet = await getCDetails(userId);
  let sDet =  await getSavingsDetails(userId);
  let sType = await getSavTypeDetails(sDet.account_type);

  res.render("savings", {
    "name": cDet.name,
    "savingsAccountNo": sDet.account_no,
    "savingsAccountBalance": sDet.balance,
    "withdrawalsLeft": sDet.remaining_withdrawals,
    "accountType": sDet.account_type,
    "interestRate": sType.interest_rate  ///////////////////////////////////////////////////////////// check
  });
});

////////////////////////////////////////////////////////////////////////////
//savings-transfers
app.get("/transfers-savings",authenticateUserToken, async (req, res) => {
  res.render("savings-transfers");
});

////////////////////////////////////////////////////////////////////////////
//savings-transfers-confirmation
app.post("/transfer-savings-do",authenticateUserToken, async (req, res) => {
  const validateSender = await validateSavingsAccount(req.body.fromAccount);
  const validateReceiver = await validateSavingsAccount(req.body.toAccount);

  const amount = parseFloat(req.body.amount);
  const validateAmount = await validateTransferAmount(amount, req.body.fromAccount);

  if ((validateSender == 1) && (validateReceiver == 1) && (validateAmount ) ) {
    res.render("savings-transfers-do", {
      status: "Successful",
    });
  } else {
    res.render("savings-transfers-do", {
      status: "Failed",
    });
  }
});

////////////////////////////////////////////////////////////////////////////
//current
app.get("/current",authenticateUserToken,async (req, res) => {
  console.log(userId);
  let cDet = await getCDetails(userId);
  let cuDet=  await getCurrentDetails(userId);
  
  res.render("current", {
    "name": cDet.name,
    "currentAccountNo": cuDet.account_no ,
    "currentAccountBalance": cuDet.balance,
  });
});

////////////////////////////////////////////////////////////////////////////
//current-transfers
app.get("/transfers-current",authenticateUserToken, (req, res) => {
  res.render("current-transfers");
});

////////////////////////////////////////////////////////////////////////////
//Fixed-Deposits
app.get("/fd",authenticateUserToken, (req, res) => {
  res.render("fd", {
    fd_id: "210383L",
    amount: "LKR.5,000,000",
    period: "1 year",
    matuarity: "12/12/2021",
    startDate: "12/12/2020",
    endDate: "12/12/2021",
    rate: "17.5%",
  });
});

////////////////////////////////////////////////////////////////////////////
//loan-request
app.post("/request-loan",authenticateUserToken, (req, res) => {
  const amount = req.body.amount;
  const duration = req.body.duration;
  res.render("loanRequests", { amount: amount, duration: duration });
});

////////////////////////////////////////////////////////////////////////////
//Loans
app.get("/loan",authenticateUserToken, (req, res) => {
  res.render("loan", {
    interestRate: "7.5%",
    accountNo: "210383L",
    loanAmount: "LKR.5,000,000",
    duration: "1 year",
    remainingPeriod: "11 months",
    totalInterest: "LKR.375,000",
    oneInstallment: "LKR.468,750",
    noOfInstallmets: "12",
    payPerIns: "LKR.39,062.50",
  });
});


//////////////////////////////////////////////////////////////////////
//employee dashboard

app.post("/searched-customer",authenticateUserToken, async (req, res) => {
  console.log(req.body.customerSearch)
  const cusId = await getCusId(req.body.customerSearch) ;

  if (cusId == false) {
    res.redirect("/dashboard");
  }
  else{
    let cDet = await getCDetails(cusId);
    let sDet =  await getSavingsDetails(cusId);
    let cuDet=  await getCurrentDetails(cusId); 

    if (cDet == undefined) {
      res.redirect("/dashboard");
    }else{

    let savingsAccountNo;
    let savingsAccountBalance;
    let withdrawalsLeft;
    let currentAccountNo; 
    let currentAccountBalance;
    let accountType;
    let savingsBId;
    let currentBId;
    let name;
    let address;
    let phone;
  
    if(cDet != undefined){
      name = cDet.name;
      address = cDet.address;
      phone = cDet.telephone;
    }
  

    if (sDet != undefined) {
      savingsAccountNo = sDet.account_no;
      savingsAccountBalance = sDet.balance;
      withdrawalsLeft = sDet.remaining_withdrawals;
      accountType = sDet.account_type;
      savingsBId = sDet.branch_id;
  
    }
    if (cuDet != undefined) {
      currentAccountNo = cuDet.account_no;
      currentAccountBalance = cuDet.balance;
      currentBId = cuDet.branch_id;
    }
    res.render("customer",{
      "name": name,
      "account_type": accountType,
      "address": address,
      "phone": phone,
      "savingsAccountNo": savingsAccountNo,
      "savingsAccountBalance": savingsAccountBalance,
      "withdrawalsLeft": withdrawalsLeft,
      "savingsBId": savingsBId,
      "currentAccountNo": currentAccountNo,
      "currentAccountBalance": currentAccountBalance,
      "currentBId": currentBId,
      "fd_exist": false,
      "loan_exist": false,
      "cusId": cusId
    });

  }
  }

});

app.get("/searched-customer",authenticateUserToken, async (req, res) => {
  res.redirect("/dashboard");
});

app.get("/create-customer",authenticateUserToken, (req, res) => {
  res.render("create-customer");

});

app.post("/created-customer",authenticateUserToken, (req, res) => {
  const name = req.body.name;
  const address = req.body.address;
  const phone = req.body.phone;
  res.render("create-customer", {
    "name": name,
    "address": address,
    "phone": phone
});
} );

app.post("/add-account",authenticateUserToken, (req, res) => {
  const cusId = req.body.cusId;

  const acc_t = req.body.acc_t ;

  res.render("add-account", {
    "cusId": cusId,
    "acc_t": acc_t
});
} );

app.post("/added-current",authenticateUserToken, (req, res) => {
  const cusId = req.body.cus_id;
  console.log(cusId);
  console.log(req.body.cus_id);
  const BId = req.body.branch_id;
  const startDate = req.body.start_date;
  const startAmount = req.body.start_amount;

  createCurrent(cusId, BId, startDate, startAmount);
  
  res.redirect("/dashboard");
} );

app.post("/add-fd",authenticateUserToken, (req, res) => {
  const cusId = req.body.cusId;
  res.render("add-fd");
} );

app.get("/add-fd",authenticateUserToken, (req, res) => {
  res.render("/add-fd");
} );


app.post("/add-loan",authenticateUserToken, (req, res) => {
  const cusId = req.body.cusId;
  res.render("add-loan");
} );


app.get("/add-loan",authenticateUserToken, (req, res) => {
  res.render("/add-loan");
} );

// app.post("/add-savings", (req, res) => {
//   res.render("add-savings", {
//     "cusId": req.body.cusId,
//     "acc_t": "s"
// });
// } );

app.post("/added-savings",authenticateUserToken, (req, res) => {
  const cusId = req.body.cus_id;
  const BId = req.body.branch_id;
  const startDate = req.body.start_date;
  const startAmount = req.body.start_amount;
  const accountType = req.body.account_type;

  createSavings(cusId, BId,accountType, startDate, startAmount);
  
  res.redirect("/dashboard");
} );



















////////////////////////////////////////////////////////////////////////////
//logout
app.get("/logout",authenticateUserToken, (req, res) => {
  res.clearCookie("jwt");
  res.redirect("/");
});

////////////////////////////////////////////////////////////////////////////
//about page
app.get("/about",authenticateUserToken, (req, res) => {
  res.render("about.ejs");
});

////////////////////////////////////////////////////////////////////////////
//contact page
app.get("/contact",authenticateUserToken, (req, res) => {
  res.render("contact.ejs");
});

////////////////////////////////////////////////////////////////////////////
//starting server
app.listen(3000, function () {
  console.log("Server started on port 3000");
});