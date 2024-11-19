<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm_Percentage_Claim_UI.aspx.cs" Inherits="Percentage_Enrollment_UI.WebForm_Percentage_Claim_UI" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Percentage Claim Audit Adhoc Submission</title>
    <style>
        .btn-green {
            background-color: green;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        .btn-orange {
            background-color: orange;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }

        .btn-reset {
            background-color: gray;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblStatus" runat="server" Text="" ForeColor="Red"></asp:Label>
            <br /><br />
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-green" OnClick="btnSubmit_Click" />
            <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="btn-reset" OnClick="btnReset_Click" />
        </div>
    </form>
</body>
</html>
