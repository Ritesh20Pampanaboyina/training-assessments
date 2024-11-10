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
            padding: 10px;
            max-height: 250px;
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

        /* Flexbox for horizontal layout */
        .program-selection-container {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
        }

        .program-checkboxes-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            width: 250px;
        }

        .dropdown-button-group {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-start;
            margin-left: 15px;
            width: 200px;
        }

        .include-exclude-boxes {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            width: 100%;
            margin-top: 10px;
        }

        .include-exclude-box {
            width: 48%;
            height: 200px;
            overflow-y: auto;
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

            <!-- Select Programs Section - Adjusted layout -->
            <div class="program-selection-container">
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

                <!-- Dropdown + Add Button -->
                <div class="dropdown-button-group">
                    <select id="ddlIncludeExclude">
                        <option value="" disabled selected>Please select</option>
                        <option value="Include">Include</option>
                        <option value="Exclude">Exclude</option>
                    </select>
                    <button type="button" class="add-btn" onclick="addToIncludeExclude()">Add>></button>
                </div>
            </div>

            <!-- Include/Exclude Boxes -->
            <div class="include-exclude-boxes">
                <div class="include-exclude-box">
                    <b>Include Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Inc" runat="server" Multiple="true" Size="10"></asp:ListBox>
                </div>
                <div class="include-exclude-box">
                    <b>Exclude Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Exc" runat="server" Multiple="true" Size="10"></asp:ListBox>
                </div>
            </div>

            <div class="form-actions">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="submit-btn" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>

            <!-- Instructions Text -->
            <div class="instructions-text">
                <p><span style="color: green;">**Green Submit button indicates Request not submitted in this 30 min slot**</span></p>
                <p><span style="color: orange;">**Orange Submit button indicates Request already submitted in this 30 min slot**</span></p>
                <p><span style="color: red;">**Please Click Reset Button to reset all the fields**</span></p>
            </div>
        </div>
    </form>

    <script type="text/javascript">
        function addToIncludeExclude() {
            var dropdown = document.getElementById("ddlIncludeExclude");
            var selectedOption = dropdown.options[dropdown.selectedIndex].value;

            // Get the selected programs
            var selectedPrograms = [];
            var checkboxes = document.querySelectorAll(".program-checkbox:checked");

            checkboxes.forEach(function (checkbox) {
                selectedPrograms.push(checkbox.parentNode.querySelector(".program-id").innerText);
            });

            if (selectedPrograms.length === 0) {
                alert("Please select at least one program to add.");
                return;
            }

            // Move selected programs to the appropriate list based on dropdown selection
            var listBox = (selectedOption === "Include") ? document.getElementById("<%= ListBox_Program_Inc.ClientID %>") : document.getElementById("<%= ListBox_Program_Exc.ClientID %>");

            selectedPrograms.forEach(function(program) {
                var option = document.createElement("option");
                option.text = program;
                listBox.add(option);
            });

            // Optionally, deselect the checkboxes after adding
            checkboxes.forEach(function(checkbox) {
                checkbox.checked = false;
            });
        }

        function toggleSelectAll(checkbox) {
            var isChecked = checkbox.checked;
            var allCheckboxes = document.querySelectorAll(".program-checkbox");

            allCheckboxes.forEach(function(chk) {
                chk.checked = isChecked;
            });
        }

        function updateSelectAllCheckbox() {
            var allCheckboxes = document.querySelectorAll(".program-checkbox");
            var selectAllCheckbox = document.getElementById("<%= chkSelectAll.ClientID %>");

            var allChecked = Array.from(allCheckboxes).every(function (chk) {
                return chk.checked;
            });

            selectAllCheckbox.checked = allChecked;
        }
    </script>
</body>
</html>



<div class="program-selection">
    <!-- Left Section: Program Checkboxes -->
    <div class="checkbox-container">
        <label for="programs" class="section-title">Program Name:</label>
        <input type="checkbox" id="selectAllPrograms" onclick="toggleAllPrograms()"> All Programs
        <div id="programCheckboxes">
            <!-- Individual Program Checkboxes (loaded dynamically or hardcoded) -->
            <input type="checkbox" name="programs" value="Program1"> Program1<br>
            <input type="checkbox" name="programs" value="Program2"> Program2<br>
            <input type="checkbox" name="programs" value="Program3"> Program3<br>
            <!-- Add more program checkboxes as needed -->
        </div>
    </div>

    <!-- Center Section: Dropdown and Add Button -->
    <div class="center-section">
        <select id="actionDropdown">
            <option value="">Please select</option>
            <option value="Include">Include</option>
            <option value="Exclude">Exclude</option>
        </select>
        <button onclick="addSelectedPrograms()">Add &gt;&gt;</button>
    </div>

    <!-- Right Section: Include and Exclude Lists -->
    <div class="include-exclude-container">
        <div class="include-box">
            <label class="section-title">Include</label>
            <select id="includeList" size="10" multiple></select>
            <a href="#" onclick="removeSelected('includeList')">Remove</a>
        </div>
        <div class="exclude-box">
            <label class="section-title">Exclude</label>
            <select id="excludeList" size="10" multiple></select>
            <a href="#" onclick="removeSelected('excludeList')">Remove</a>
        </div>
    </div>
</div>
