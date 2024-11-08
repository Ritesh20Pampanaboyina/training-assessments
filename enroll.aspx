
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

        .add-btn, .submit-btn, .reset-btn {
            padding: 5px 15px;
            color: white;
            border: none;
            cursor: pointer;
            margin-left: 10px;
        }

        .add-btn {
            background-color: #4CAF50;
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

        .program-checkboxes {
            border: 1px solid #ccc;
            padding: 5px;
            height: 200px;
            width: 200px;
            overflow-y: scroll;
            margin-top: 5px;
        }

        .program-item {
            display: flex;
            align-items: center;
            margin-bottom: 5px;
        }

        .program-checkbox {
            margin-right: 10px;
            width: 15px;
            height: 15px;
            accent-color: blue;
        }

        .program-id {
            flex-grow: 1;
        }
    </style>
    <script type="text/javascript">
        function toggleSelectAll(selectAllCheckbox) {
            var checkboxes = document.querySelectorAll('.program-checkbox');
            checkboxes.forEach(function (checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }

        function updateSelectAllCheckbox() {
            var checkboxes = document.querySelectorAll('.program-checkbox');
            var selectAllCheckbox = document.getElementById('<%= chkSelectAll.ClientID %>');
            selectAllCheckbox.checked = Array.from(checkboxes).every(function (checkbox) {
                return checkbox.checked;
            });
        }

        window.onload = function() {
            var selectAllCheckbox = document.getElementById('<%= chkSelectAll.ClientID %>');
            selectAllCheckbox.checked = true;
            toggleSelectAll(selectAllCheckbox);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Percentage Enrollment Audit Adhoc Selection Criteria</h2>

        <div class="form-container">
            <div class="form-group">
                <label for="ddlAuditType">Type of Audit:</label>
                <asp:DropDownList ID="ddlAuditType" runat="server">
                    <asp:ListItem Value="FOCUS">FOCUS</asp:ListItem>
                    <asp:ListItem Value="RANDOM">RANDOM</asp:ListItem>
                    <asp:ListItem Value="ADHOC">ADHOC</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlEnrollmentSpecialist">Choose Enrollment Specialist:</label>
                <asp:DropDownList ID="ddlEnrollmentSpecialist" runat="server">
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>

            <div class="form-group">
                <label for="ddlDSU">Choose DSU:</label>
                <asp:DropDownList ID="ddlDSU" runat="server">
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>

            <div class="form-group">
                <label for="ddlGroups">Select Groups:</label>
                <asp:DropDownList ID="ddlGroups" runat="server">
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

            <!-- Updated "Select Programs" section -->
            <div class="form-group">
                <div style="display: flex; align-items: flex-start;">
                    <label for="programCheckboxes">Select Programs:</label>
                    <div class="program-checkboxes" id="programCheckboxes" runat="server">
                        <div class="program-item">
                            <asp:CheckBox ID="chkSelectAll" runat="server" CssClass="program-checkbox" 
                                          OnClientClick="toggleSelectAll(this); return false;" />
                            <label>Select All</label>
                        </div>
                        <asp:Repeater ID="rptPrograms" runat="server">
                            <ItemTemplate>
                                <div class="program-item">
                                    <asp:CheckBox ID="chkProgram" runat="server" CssClass="program-checkbox" 
                                                  OnClick="updateSelectAllCheckbox()" />
                                    <label class="program-id"><%# Eval("ProgramId") %></label>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Audit Request" CssClass="submit-btn" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>
        </div>

        <p>**Green Submit button indicates Request not submitted in this 30 min slot**<br />
           **Please Click Reset Button to reset all the fields**
        </p>
    </form>
</body>
</html>

