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
            align-items: flex-start; /* Center align vertically */
            justify-content: flex-start;
            width: 100%;
            margin-bottom: 15px;
        }
 
        /* Select Programs Section */
        .program-checkboxes-container {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            width: 35%; /* 25% width for Select Programs container */
            margin-right: 15px; /* Space between Select Programs and next elements */
        }
 
        /* Dropdown + Add Button Section */
        .dropdown-button-group {
            display: flex;
            flex-direction: row; /* Align the dropdown and button vertically */
            justify-content: center;
            align-items: flex-start;
            margin-right: 20px;
        }
 
        .include-exclude-boxes {
            display: flex;
            justify-content: space-between;
            align-items: flex-start; /* Center align vertically */
            width: 40%; /* Keep this as is or adjust to fit your layout */
            flex-direction: row; /* Change from row to column to stack them vertically */
        }
 
        .include-exclude-box {
            width: 90%; /* Adjust width to 100% of the container */
            height: 200px; /* Increase height to make the boxes bigger vertically */
            overflow-y: auto; /* Add scroll bar if content overflows */
            margin-bottom: 10px; /* Add spacing between boxes */
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

            <div class="form-group">
    <label for="programCheckboxes">Select Programs:</label>
    <div class="program-selection-container">
        <!-- Select Programs -->
        <div class="program-checkboxes-container">
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
                        <asp:CheckBox ID="chkProgram" runat="server" CssClass="program-checkbox" OnClick="updateSelectAllCheckbox()" />
                        <label class="program-id"><%# Eval("ProgramId") %></label>
                        <!-- Make sure the ProgramId is displayed or stored properly -->
                        <asp:Label ID="lblProgramId" runat="server" Text='<%# Eval("ProgramId") %>' Visible="false"></asp:Label>
                    </div>
                </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <!-- Dropdown + Add Button (Now aligned next to the Select Programs) -->
        <div class="dropdown-button-group">
            <select id="ddlIncludeExclude">
                <option value="" disabled selected>Please select</option>
                <option value="Include">Include</option>
                <option value="Exclude">Exclude</option>
            </select>
            <button type="button" class="add-btn" onclick="addToIncludeExclude()">Add>></button>
        </div>
    </div>
</div>


            <!-- Include/Exclude Boxes -->
            <div class="include-exclude-boxes">
                <div class="include-exclude-box">
                    <b>Include Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Inc" runat="server" Multiple="true" Size="10"></asp:ListBox>
                    <a href="#" onclick="removeSelected('includeList')">Remove</a>
                </div>
                <div class="include-exclude-box">
                    <b>Exclude Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Exc" runat="server" Multiple="true" Size="10"></asp:ListBox>
                    <a href="#" onclick="removeSelected('excludeList')">Remove</a>
                </div>
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>


            <div class="form-actions">
                <button class="submit-btn" type="submit" id="btnSubmit">Submit</button>
                <button class="reset-btn" type="reset" id="btnReset">Reset</button>
            </div>
        </div>

        <!-- Instructions Text -->
            <div class="instructions-text">
                <p><span style="color: green;">**Green Submit button indicates Request not submitted in this 30 min slot**</span></p>
                <p><span style="color: orange;">**Orange Submit button indicates Request already submitted in this 30 min slot**</span></p>
                <p><span style="color: red;">**Please Click Reset Button to reset all the fields**</span></p>
            </div>
    </form>

    <script type="text/javascript">
        function addToIncludeExclude() {
            var dropdown = document.getElementById("ddlIncludeExclude");
            var selectedOption = dropdown.options[dropdown.selectedIndex].value;

            var checkboxes = document.querySelectorAll('.program-checkbox:checked');
            if (checkboxes.length === 0) {
                alert("Please select at least one program to add.");
                return;
            }

            var selectedPrograms = [];
            checkboxes.forEach(function (checkbox) {
                var programId = checkbox.parentNode.querySelector(".program-id").innerText.trim();
                selectedPrograms.push(programId);
            });

            if (!selectedOption) {
                alert("Please select whether to Include or Exclude before adding programs.");
                return;
            }

            var listBox;
            if (selectedOption === "Include") {
                listBox = document.getElementById("<%= ListBox_Program_Inc.ClientID %>");
    } else if (selectedOption === "Exclude") {
                listBox = document.getElementById("<%= ListBox_Program_Exc.ClientID %>");
            }

            selectedPrograms.forEach(function (program) {
                var option = document.createElement("option");
                option.text = program;
                listBox.add(option);
            });

            checkboxes.forEach(function (checkbox) {
                checkbox.checked = false;
            });
        }




        // Handle the Select All checkbox
        function updateSelectAllCheckbox() {
            var allCheckboxes = document.querySelectorAll('.program-checkbox');
            var selectAllCheckbox = document.getElementById('chkSelectAll');
            var checkedCount = 0;

            allCheckboxes.forEach(function(checkbox) {
                if (checkbox.checked) {
                    checkedCount++;
                }
            });

            selectAllCheckbox.checked = (checkedCount === allCheckboxes.length);
        }

        // Handle the Select All behavior
        function toggleSelectAll(selectAllCheckbox) {
            var allCheckboxes = document.querySelectorAll('.program-checkbox');
            allCheckboxes.forEach(function(checkbox) {
                checkbox.checked = selectAllCheckbox.checked;
            });
        }

        // Remove selected options from ListBoxes
        function removeSelected(listType) {
            var listBox = document.getElementById(listType === 'includeList' ? "<%= ListBox_Program_Inc.ClientID %>" : "<%= ListBox_Program_Exc.ClientID %>");
            var selectedOptions = Array.from(listBox.selectedOptions);

            selectedOptions.forEach(function (option) {
                listBox.removeChild(option);
            });
        }
    </script>
</body>
</html>

