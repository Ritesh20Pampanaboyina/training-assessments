<%@ Page Language="C#" AutoEventWireup="true" CodeFile="YourPage.aspx.cs" Inherits="YourNamespace_YourPage" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Percentage Enrollment Audit Adhoc Selection Criteria</title>
    <style>
        /* CSS Styling */
        .form-group {
            margin-bottom: 20px;
        }

        .dropdown-button-group, .include-exclude-box {
            margin-top: 10px;
        }

        .add-btn {
            margin-left: 10px;
            background-color: #28a745;
            color: white;
            padding: 5px 10px;
            border: none;
            cursor: pointer;
        }

        .include-exclude-box {
            display: inline-block;
            margin-right: 20px;
            vertical-align: top;
        }

        .program-list-box {
            width: 200px;
        }

        .program-checkboxes {
            max-height: 200px;
            overflow-y: auto;
            border: 1px solid #ccc;
            padding: 10px;
            width: 100%;
        }

        .program-item {
            display: flex;
            align-items: center;
        }

        .program-item label {
            margin-left: 5px;
        }
    </style>
    <script>
        // JavaScript for Select All functionality
        function toggleSelectAll(selectAllCheckbox) {
            let checkboxes = document.querySelectorAll('.program-checkbox');
            checkboxes.forEach(checkbox => {
                if (checkbox !== selectAllCheckbox) {
                    checkbox.checked = selectAllCheckbox.checked;
                }
            });
        }

        function updateSelectAllCheckbox() {
            let checkboxes = document.querySelectorAll('.program-checkbox:not(#chkSelectAll)');
            let allChecked = Array.from(checkboxes).every(checkbox => checkbox.checked);
            document.getElementById('chkSelectAll').checked = allChecked;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-group field-container">
            <!-- Type of Audit Dropdown -->
            <div>
                <label for="ddlAuditType">Type of Audit:</label>
                <asp:DropDownList ID="ddlAuditType" runat="server">
                    <asp:ListItem Value="FOCUS">FOCUS</asp:ListItem>
                    <asp:ListItem Value="AUDIT">AUDIT</asp:ListItem>
                    <!-- Additional options as needed -->
                </asp:DropDownList>
            </div>

            <!-- Select Programs Checkbox List with Select All -->
            <div>
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

            <!-- Dropdown, Add Button, Include and Exclude boxes -->
            <div>
                <!-- Dropdown Button Group -->
                <div class="dropdown-button-group">
                    <label for="ddlPrograms">Programs:</label>
                    <asp:DropDownList ID="ddlPrograms" runat="server">
                        <asp:ListItem Value="">Please Select</asp:ListItem>
                        <asp:ListItem Value="Program1">Program 1</asp:ListItem>
                        <asp:ListItem Value="Program2">Program 2</asp:ListItem>
                        <!-- Add additional items here as needed -->
                    </asp:DropDownList>
                    <asp:Button ID="btnAdd" runat="server" Text="Add >>" CssClass="add-btn" />
                </div>

                <!-- Include Programs Box -->
                <div class="include-exclude-box">
                    <b>Include Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Inc" runat="server" SelectionMode="Multiple" CssClass="program-list-box"></asp:ListBox>
                </div>

                <!-- Exclude Programs Box -->
                <div class="include-exclude-box">
                    <b>Exclude Programs</b><br />
                    <asp:ListBox ID="ListBox_Program_Exc" runat="server" SelectionMode="Multiple" CssClass="program-list-box"></asp:ListBox>
                </div>
            </div>
        </div>

        <asp:Button ID="btnSubmit" runat="server" Text="Submit Audit Request" CssClass="submit-btn" />
        <asp:Button ID="btnReset" runat="server" Text="Reset" CssClass="reset-btn" />
    </form>
</body>
</html>
