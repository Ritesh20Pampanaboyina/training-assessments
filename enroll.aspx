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

        .program-checkboxes {
            border: 1px solid #ccc;
            padding: 5px;
            height: 200px;
            width: 180px; /* Slightly reduced width */
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

        .include-exclude-box {
            margin-top: 10px;
        }

        /* Adjustments to the horizontal layout */
        .select-programs-container {
            display: flex;
            align-items: center; /* Center align vertically */
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 15px;
        }

        /* Select Programs Section */
        .program-checkboxes-container {
            display: flex;
            flex-direction: column;
            justify-content: flex-start;
            width: 25%; /* 25% width for Select Programs container */
            margin-right: 15px; /* Space between Select Programs and next elements */
        }

        /* Dropdown + Add Button Section */
        .dropdown-button-group {
            display: flex;
            flex-direction: column; /* Align the dropdown and button vertically */
            align-items: flex-start;
            margin-right: 20px;
        }

        /* Include/Exclude Boxes Section */
        .include-exclude-boxes {
            display: flex;
            justify-content: space-between;
            align-items: center; /* Center align vertically */
            width: 45%; /* Make sure it takes 45% width */
        }

        .include-exclude-box {
            width: 48%; /* Adjusting size of Include/Exclude boxes */
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

        window.onload = function () {
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
                <asp:DropDownList ID="ddlAuditType" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="FOCUS">FOCUS</asp:ListItem>
                    <asp:ListItem Value="RANDOM">RANDOM</asp:ListItem>
                    <asp:ListItem Value="ADHOC">ADHOC</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="form-group">
                <label for="ddlEnrollmentSpecialist">Choose Enrollment Specialist:</label>
                <asp:DropDownList ID="ddlEnrollmentSpecialist" runat="server" AutoPostBack="true">
                    <asp:ListItem Value="">Please Select</asp:ListItem>
                    <asp:ListItem Value="ALL">ALL</asp:ListItem>
                </asp:DropDownList>
                <button class="add-btn" type="button">Add>></button>
            </div>

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
                <!-- Select Programs -->
                <div class="program-checkboxes-container">
                    <label for="programCheckboxes">Select Programs:</label>
                    <div class="program-checkboxes" id="programCheckboxes" runat="server">
                        <div class="program-item">
                            <asp:CheckBox ID="chkSelectAll" runat="server" CssClass="program-checkbox" 
                                          OnClientClick="toggleSelectAll(this); return false;" 
                                          OnCheckedChanged="chkSelectAll_CheckedChanged" AutoPostBack="true" />
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

                <!-- Please Select Dropdown + Add Button -->
                <div class="dropdown-button-group">
                    <select>
                        <option>Please Select</option>
                    </select>
                    <button type="button" class="add-btn" onclick="addToInclude()">Add &gt;&gt;</button>
                </div>

                <!-- Include/Exclude Boxes -->
                <div class="include-exclude-boxes">
                    <div class="include-exclude-box">
                        <b>Include Programs</b><br />
                        <asp:ListBox ID="ListBox_Program_Inc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
                    </div>
                    <div class="include-exclude-box">
                        <b>Exclude Programs</b><br />
                        <asp:ListBox ID="ListBox_Program_Exc" runat="server" Multiple="true" Size="10" CssClass="program-list-box"></asp:ListBox>
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


.select-programs-container {
    display: flex;
    align-items: flex-start; /* Align items to the top */
    justify-content: flex-start;
    width: 100%;
    margin-bottom: 15px;
}

.program-checkboxes-container {
    width: 30%; /* Increase width for better alignment */
    margin-right: 15px;
}

.dropdown-button-group {
    display: flex;
    flex-direction: column; /* Align dropdown and button vertically */
    justify-content: center; /* Center within the column */
    margin-right: 20px;
    height: 100%; /* Fill available space vertically */
}

.include-exclude-boxes {
    display: flex;
    justify-content: space-between;
    align-items: flex-start; /* Align items to the top */
    width: 40%; /* Adjust width */
}

.include-exclude-box {
    width: 48%; /* Adjusting size of Include/Exclude boxes */
}
