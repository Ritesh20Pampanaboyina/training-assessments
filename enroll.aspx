<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Percentage_Enrollment_UI.aspx.cs" Inherits="Percentage_Enrollment_UI.Percentage_Enrollment_UI" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Percentage Enrollment UI</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h2 {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: center;
            font-size: 20px;
        }

        .form-container {
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 10px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: inline-block;
            width: 220px;
        }

        input[type="text"], input[type="date"], select {
            padding: 5px;
            width: 250px;
        }

        /*span.field-validation-error {
            color: red;*/  /* Change error message text color to red */
            /*font-weight: bold;*/  /* Optional: makes the error message bold */
        /*}*/

        .add-btn, .submit-btn, .reset-btn {
            padding: 5px 10px;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }

        .add-btn {
            background-color: #4CAF50;
            font-size: 14px;
            padding: 5px 10px;
        }

        .submit-btn {
            background-color: #28a745;
        }

        .reset-btn {
            background-color: #007bff;
        }

        .form-actions {
            margin-top: 20px;
            text-align: right;
        }

        .program-checkboxes,.program-checkboxes-specialists {
            border: 1px solid #ccc;
            padding: 5px;
            height: 200px;
            width: 180px; 
            overflow-y: scroll;
            margin-top: 5px;
        }

        .program-item,.program-item-specialists {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .program-checkbox,.program-checkbox-specialists {
            margin-right: 10px;
            width: 15px;
            height: 15px;
            accent-color: blue;
        }

        .program-id {
            flex-grow: 1;
        }


        .include-exclude-box {
            margin-top: 10px;
            margin-bottom: 10px; 
        }

        
        .select-programs-container, .select-specialists-container {
            display: flex;
            align-items: flex-start; /
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 15px;
        }

        .program-checkboxes-container, .program-checkboxes-container-specialists {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            width: 35%;
            margin-right: 15px; 
        }

        
        .dropdown-button-group {
            display: flex;
            flex-direction: row; 
            justify-content: center;
            align-items: flex-start;
            margin-right: 20px;
        }

        .include-exclude-boxes {
            display: flex;
            justify-content: flex-start;
            align-items: flex-start; 
            width: 40%; 
            flex-direction: row; 
            margin-right: 15px;

        }

        .include-exclude-box {
            width: 40%; 
            height: 150px; 
            overflow-y: auto; 
            margin-bottom: 10px; 
            margin-right: 20px;
        }

        .program-list-box {
            height: 90%; 
        }

        
        .instructions-text {
            font-size: 12px;
            color: #555;
            margin-top: 20px;
            padding-top: 10px;
            border-top: 1px solid #ccc;
            text-align: left;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <h2>Percentage Enrollment Audit Adhoc Selection Criteria</h2>

        <div class="form-container">
            <div class="form-group">
                <label for="ddlAuditFileType1">Type of Audit:</label>
                <asp:DropDownList ID="ddlAuditFileType1" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="FOCUS">FOCUS</asp:ListItem>
                    <asp:ListItem Value="RANDOM">RANDOM</asp:ListItem>
                    <asp:ListItem Value="ADHOC">ADHOC</asp:ListItem>
                </asp:DropDownList>
            </div>

            <%--<div class="form-group">
                <label for="ddlEnrollmentSpecialist">Choose Enrollment Specialist:</label>
                <asp:DropDownList ID="ddlEnrollmentSpecialist" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>--%>

            <div class="form-group">
                <label for="ddlDSU">Choose DSU:</label>
                <asp:DropDownList ID="ddlDSU" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>

            <div class="form-group">
                <label for="ddlGroups">Select Groups:</label>
                <asp:DropDownList ID="ddlGroups" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>

            <div class="form-group">
                <label for="txtAddsTerms"># of Adds/Terms:</label>
                <asp:TextBox ID="txtAddsTerms" runat="server" MaxLength="5"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtPercentChanges">% of Member Account Changes:</label>
                <asp:TextBox ID="txtPercentChanges" runat="server" MaxLength="3"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtBeginDate">Start Date:</label>
                <asp:TextBox ID="txtBeginDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>

            <div class="form-group">
                <label for="txtEndDate">End Date:</label>
                <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date"></asp:TextBox>
            </div>

            <!-- Select Programs Section -->
<div class="form-group select-programs-container">
    <div class="program-checkboxes-container">
        <label for="programCheckboxes">Select Programs:</label>
        <div class="program-checkboxes" id="programCheckboxes" runat="server">
            <div class="program-item">
                <asp:CheckBox ID="chkSelectAll" runat="server" CssClass="program-checkbox" 
                              OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="true" />
                <label>Select All</label>
            </div>
            <asp:Repeater ID="rptPrograms" runat="server">
                <ItemTemplate>
                    <asp:CheckBox ID="chkProgram" runat="server" />
                    <asp:Label ID="lblProgramId" runat="server" Text='<%# Eval("ProgramId") %>' />
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="dropdown-button-group">
        <asp:DropDownList ID="ddlSelectionType" runat="server" AutoPostBack="true">
            <asp:ListItem Text="Please Select" Value="" />
            <asp:ListItem Text="Include" Value="Include" />
            <asp:ListItem Text="Exclude" Value="Exclude" />
        </asp:DropDownList>
        <asp:Button ID="btnAdd" runat="server" Text="Add" OnClick="btnAdd_Click" />
    </div>

    <div class="include-exclude-boxes">
        <div class="include-exclude-box">
            <b>Include Programs</b><br />
            <asp:ListBox ID="ListBox_Program_Inc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
            <asp:Button ID="btnRemoveProgramInclude" runat="server" Text="Remove" OnClick="btnRemoveProgramInclude_Click" />
        </div>
        <div class="include-exclude-box">
            <b>Exclude Programs</b><br />
            <asp:ListBox ID="ListBox_Program_Exc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
            <asp:Button ID="btnRemoveProgramExclude" runat="server" Text="Remove" OnClick="btnRemoveProgramExclude_Click" />
        </div>
    </div>
</div>

<div class="form-group select-specialists-container">
    <div class="program-checkboxes-container-specialists">
        <label for="specialistCheckboxes">Choose Enrollment Specialists:</label>
        <div class="program-checkboxes-specialists" id="specialistCheckboxes" runat="server">
            <div class="program-item-specialists">
                <asp:CheckBox ID="chkSelectAllSpecialists" runat="server" CssClass="program-checkbox-specialists" 
                              OnCheckedChanged="chkSelectAllSpecialists_CheckedChanged" AutoPostBack="true" />
                <label>Select All</label>
            </div>
            <asp:Repeater ID="rptSpecialists" runat="server">
                <ItemTemplate>
                    <div class="program-item-specialists">
                        <asp:CheckBox ID="chkSpecialist" runat="server" CssClass="program-checkbox-specialists" />
                        <asp:Label ID="lblSpecialistId" runat="server" Text='<%# Eval("op_user") %>' CssClass="program-id" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>

    <div class="dropdown-button-group">
        <asp:DropDownList ID="ddlSpecialistSelectionType" runat="server" AutoPostBack="true">
            <asp:ListItem Text="Please Select" Value="" />
            <asp:ListItem Text="Include" Value="Include" />
            <asp:ListItem Text="Exclude" Value="Exclude" />
        </asp:DropDownList>
        <asp:Button ID="btnAddSpecialist" runat="server" Text="Add" OnClick="btnAddSpecialist_Click" />
    </div>

    <div class="include-exclude-boxes">
        <div class="include-exclude-box">
            <b>Include Specialists</b><br />
            <asp:ListBox ID="ListBox_Specialist_Inc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
            <asp:Button ID="btnRemoveSpecialistInclude" runat="server" Text="Remove" OnClick="btnRemoveSpecialistInclude_Click" />
        </div>
        <div class="include-exclude-box">
            <b>Exclude Specialists</b><br />
            <asp:ListBox ID="ListBox_Specialist_Exc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
            <asp:Button ID="btnRemoveSpecialistExclude" runat="server" Text="Remove" OnClick="btnRemoveSpecialistExclude_Click" />
        </div>
    </div>
</div>




            <div class="form-actions">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="submit-btn" OnClick="btnSubmit_Click" Visible="true" />
                <asp:Button ID="btnCheck" runat="server" Text="Check" CssClass="submit-btn" Visible="false" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>

            

            
            <%--<div class="instructions-text">
                <p><span style="color: green;">**Green Submit button indicates Request not submitted in this 30 min slot**</span></p>
                <p><span style="color: orange;">**Orange Submit button indicates Request already submitted in this 30 min slot**</span></p>
                <p><span style="color: red;">**Please Click Reset Button to reset all the fields**</span></p>
            </div>--%>
            <div class="row" style="text-align: center;">
                    <div class="col-sm-12">
                        <asp:Label ID="Label1" runat="server" Class="alert alert-danger" Font-Bold="true"></asp:Label>
                    </div>
                </div>
                <div class="row" >
                    <div class="col-sm-12">
                        <asp:Label ID="lblMessage_green" runat="server" Style="color:Green;" Font-Bold="true">**Green Submit button indicates Request not submitted in this 30 min slot</asp:Label>

                    </div>

                </div>
                <div class="row" >
                    <div class="col-sm-12">
                        <asp:Label ID="lblMessage_orange" runat="server" Style="color:Orange;" Font-Bold="true">**Orange Submit button indicates Request already submitted in this 30 min slot</asp:Label>

                    </div>

                </div>
                <div class="row" >
                    <div class="col-sm-12">
                        <asp:Label ID="lblMessage_Red" runat="server" Style="color:Red;" Font-Bold="true">**Please Click Reset Button to reset all the fields</asp:Label>

                    </div>

                </div>
            </div>
       
    </form>

</body>
</html>
