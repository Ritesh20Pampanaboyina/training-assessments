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
            margin-bottom: 10px; /* Added spacing between the two boxes */
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
            width: 40%; /* Reduced the width of the Include/Exclude boxes */
            height: 150px; /* Reduced height for both Include and Exclude boxes */
            overflow-y: auto; /* Add scroll bar if content overflows */
            margin-bottom: 10px; /* Added spacing between the boxes */
        }

        .program-list-box {
            height: 90%; /* Make the list box take most of the container height */
        }

        /* Style for the instructions text at the bottom */
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
                    <button type="button" class="add-btn" onclick="addToInclude()">Add>></button>
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
                <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="submit-btn" OnClick="btnSubmit_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" OnClick="btnReset_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Green" Visible="false"></asp:Label>

            <!-- Instructions Text inside the main form container -->
            <div class="instructions-text">
                <p><span style="color: green;">**Green Submit button indicates Request not submitted in this 30 min slot**</span></p>
                <p><span style="color: orange;">**Orange Submit button indicates Request already submitted in this 30 min slot**</span></p>
                <p><span style="color: red;">**Please Click Reset Button to reset all the fields**</span></p>
            </div>
        </div>
    </form>
</body>
</html>
