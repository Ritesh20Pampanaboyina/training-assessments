using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Percentage_Enrollment_UI
{
    public partial class Percentage_Enrollment_UI : Page
    {
        private DataAccessLayer dataAccess = new DataAccessLayer();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPrograms();
                LoadEnrollmentSpecialists();

                ddlSelectionType.Enabled = !chkSelectAll.Checked;
                btnAdd.Enabled = !chkSelectAll.Checked;

                ddlSpecialistSelectionType.Enabled = !chkSelectAllSpecialists.Checked;
                btnAddSpecialist.Enabled = !chkSelectAllSpecialists.Checked;

                SetDropdownEnabledState(ListBox_Program_Inc, ListBox_Program_Exc, chkSelectAll.Checked);
                SetDropdownEnabledState(ListBox_Specialist_Inc, ListBox_Specialist_Exc, chkSelectAllSpecialists.Checked);
            }
        }

        private void LoadPrograms()
        {
            
            DataTable programs = dataAccess.GetPrograms();

            if (programs.Rows.Count == 0)
            {
                lblMessage.Text = "No programs found.";
                lblMessage.Visible = true;
            }
            else
            {
                rptPrograms.DataSource = programs;
                rptPrograms.DataBind();
            }

            
            chkSelectAll.Checked = true;
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }
        }

        private void LoadEnrollmentSpecialists()
        {
            
            DataTable specialists = dataAccess.GetEnrollmentSpecialists();

            if (specialists.Rows.Count == 0)
            {
                lblMessage.Text = "No enrollment specialists found.";
                lblMessage.Visible = true;
            }
            else
            {
                rptSpecialists.DataSource = specialists;
                rptSpecialists.DataBind();
            }

            
            chkSelectAllSpecialists.Checked = true;
            foreach (RepeaterItem item in rptSpecialists.Items)
            {
                CheckBox chkSpecialist = (CheckBox)item.FindControl("chkSpecialist");
                chkSpecialist.Checked = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            // Define InterfaceId - here it's fixed as "INT00000240"
            string Interfaceid = "INT00000240"; // Use the InterfaceId you need to check
            string Check_Flag = "";

            try
            {
                // Fetch the Adhoc Flag from the database based on InterfaceId
                DataTable dt_new = dataAccess.GetAdhocFlag(Interfaceid);

                // Ensure the DataTable contains data
                if (dt_new.Rows.Count > 0)
                {
                    Check_Flag = dt_new.Rows[0][0].ToString(); // Assuming the flag is in the first column
                }

                // Check the flag value and set visibility of buttons accordingly
                if (Check_Flag == "T") // If flag is "T", show btnCheck and hide btnSubmit
                {
                    btnCheck.Visible = true;
                    btnSubmit.Visible = false;
                }
                else // If flag is not "T", show btnSubmit and hide btnCheck
                {
                    btnCheck.Visible = false;
                    btnSubmit.Visible = true;
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions that occur during the database call
                lblMessage.Text = "Error retrieving Adhoc flag data: " + ex.Message;
                lblMessage.Visible = true;
                return;
            }

            // Now proceed with the rest of the logic for submitting the audit request
            string includedPrograms = GetSelectedItems(ListBox_Program_Inc);
            string excludedPrograms = GetSelectedItems(ListBox_Program_Exc);
            string includedSpecialists = GetSelectedItems(ListBox_Specialist_Inc);
            string excludedSpecialists = GetSelectedItems(ListBox_Specialist_Exc);

            // Validate start and end dates
            if (!DateTime.TryParse(txtBeginDate.Text, out DateTime startDate))
            {
                lblMessage.Text = "Please enter a valid Begin Date.";
                lblMessage.Visible = true;
                return;
            }

            if (!DateTime.TryParse(txtEndDate.Text, out DateTime endDate))
            {
                lblMessage.Text = "Please enter a valid End Date.";
                lblMessage.Visible = true;
                return;
            }

            if (endDate > DateTime.Today)
            {
                lblMessage.Text = "End Date cannot be set in the future.";
                lblMessage.Visible = true;
                return;
            }

            // Submit the audit request if everything is valid
            dataAccess.SubmitAuditRequest(
                ddlAuditFileType1.SelectedValue,
                //ddlEnrollmentSpecialist.SelectedValue, // Uncomment and use if needed
                ddlDSU.SelectedValue,
                ddlGroups.SelectedValue,
                txtAddsTerms.Text,
                txtPercentChanges.Text,
                startDate,
                endDate,
                includedPrograms,
                excludedPrograms,
                includedSpecialists,
                excludedSpecialists
            );

            // Show a success message
            lblMessage.Text = "Audit request submitted successfully!";
            lblMessage.Visible = true;
        }


        private string GetSelectedItems(ListBox listBox)
        {
            List<string> selectedIds = new List<string>();
            foreach (ListItem item in listBox.Items)
            {
                selectedIds.Add(item.Value);
            }
            return string.Join(";", selectedIds);
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            AddItemsToListBox(rptPrograms, ddlSelectionType, ListBox_Program_Inc, ListBox_Program_Exc, "chkProgram", "lblProgramId");
        }

        protected void btnAddSpecialist_Click(object sender, EventArgs e)
        {
            AddItemsToListBox(rptSpecialists, ddlSpecialistSelectionType, ListBox_Specialist_Inc, ListBox_Specialist_Exc, "chkSpecialist", "lblSpecialistId");
        }

        private void AddItemsToListBox(Repeater repeater, DropDownList selectionTypeDropdown, ListBox includeListBox, ListBox excludeListBox, string checkBoxId, string labelId)
        {
            if (repeater.Items.Count == 0)
            {
                lblMessage.Text = "No items available to select.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                return;
            }

            string selectionType = selectionTypeDropdown.SelectedValue;
            if (string.IsNullOrEmpty(selectionType))
            {
                lblMessage.Text = "Please select either 'Include' or 'Exclude' from the dropdown.";
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Visible = true;
                return;
            }

            bool atLeastOneSelected = false;
            foreach (RepeaterItem item in repeater.Items)
            {
                CheckBox chkItem = (CheckBox)item.FindControl(checkBoxId);
                Label lblItemId = (Label)item.FindControl(labelId);

                if (chkItem != null && lblItemId != null && chkItem.Checked)
                {
                    atLeastOneSelected = true;

                    if (selectionType == "Include" && !includeListBox.Items.Contains(new ListItem(lblItemId.Text)))
                    {
                        includeListBox.Items.Add(new ListItem(lblItemId.Text, lblItemId.Text));
                    }
                    else if (selectionType == "Exclude" && !excludeListBox.Items.Contains(new ListItem(lblItemId.Text)))
                    {
                        excludeListBox.Items.Add(new ListItem(lblItemId.Text, lblItemId.Text));
                    }

                    chkItem.Checked = false;
                }
            }

            lblMessage.Visible = !atLeastOneSelected;
            lblMessage.Text = atLeastOneSelected ? "" : "Please select at least one item to add.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkSelectAllPrograms = (CheckBox)sender;

            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = chkSelectAllPrograms.Checked;
                chkProgram.Enabled = !chkSelectAllPrograms.Checked; // Disable if "Select All" is checked
            }

            ddlSelectionType.Enabled = !chkSelectAll.Checked;

            // Optional: Also disable the "Add" button when "Select All" is checked
            btnAdd.Enabled = !chkSelectAll.Checked;

            // Enable or disable "Include" and "Exclude" dropdowns based on the "Select All" checkbox status
            SetDropdownEnabledState(ListBox_Program_Inc, ListBox_Program_Exc, chkSelectAllPrograms.Checked);
        }


        // Disable "Include" and "Exclude" dropdowns for programs if "Select All" is checked



        protected void chkSelectAllSpecialists_CheckedChanged(object sender, EventArgs e)
        {
            CheckBox chkSelectAllSpecialists = (CheckBox)sender;

            foreach (RepeaterItem item in rptSpecialists.Items)
            {
                CheckBox chkSpecialist = (CheckBox)item.FindControl("chkSpecialist");
                chkSpecialist.Checked = chkSelectAllSpecialists.Checked;
                chkSpecialist.Enabled = !chkSelectAllSpecialists.Checked; // Disable if "Select All" is checked
            }

            ddlSpecialistSelectionType.Enabled = !chkSelectAllSpecialists.Checked;
            btnAddSpecialist.Enabled = !chkSelectAllSpecialists.Checked;
            // Enable or disable "Include" and "Exclude" dropdowns based on the "Select All" checkbox status
            SetDropdownEnabledState(ListBox_Specialist_Inc, ListBox_Specialist_Exc, chkSelectAllSpecialists.Checked);
        }



        private void SetDropdownEnabledState(ListBox listBoxInclude, ListBox listBoxExclude, bool selectAllChecked)
        {
            // Disable the ListBox controls when "Select All" is checked, or enable them otherwise
            listBoxInclude.Enabled = !selectAllChecked;
            listBoxExclude.Enabled = !selectAllChecked;
        }


        //private void ToggleAllCheckboxes(Repeater repeater, CheckBox selectAllCheckBox, string checkBoxId)
        //{
        //    bool isChecked = selectAllCheckBox.Checked;
        //    foreach (RepeaterItem item in repeater.Items)
        //    {
        //        CheckBox chkItem = (CheckBox)item.FindControl(checkBoxId);
        //        if (chkItem != null)
        //        {
        //            chkItem.Checked = isChecked;
        //        }
        //    }
        //}

        

        protected void btnRemoveProgramInclude_Click(object sender, EventArgs e)
        {
            RemoveSelectedItems(ListBox_Program_Inc);
            ListBox_Program_Inc.Items.Clear();
        }

        protected void btnRemoveProgramExclude_Click(object sender, EventArgs e)
        {
            RemoveSelectedItems(ListBox_Program_Exc);
            ListBox_Program_Exc.Items.Clear();
        }

        protected void btnRemoveSpecialistInclude_Click(object sender, EventArgs e)
        {
            RemoveSelectedItems(ListBox_Specialist_Inc);
            ListBox_Specialist_Inc.Items.Clear();
        }

        protected void btnRemoveSpecialistExclude_Click(object sender, EventArgs e)
        {
            RemoveSelectedItems(ListBox_Specialist_Exc);
            ListBox_Specialist_Exc.Items.Clear();
        }

        private void RemoveSelectedItems(ListBox listBox)
        {
            // Remove selected items from the ListBox in reverse order
            for (int i = listBox.Items.Count - 1; i >= 0; i--)
            {
                if (listBox.Items[i].Selected)
                {
                    listBox.Items.RemoveAt(i);
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlAuditFileType1.SelectedIndex = 0;
            //ddlEnrollmentSpecialist.SelectedIndex = 0;
            ddlDSU.SelectedIndex = 0;
            ddlGroups.SelectedIndex = 0;
            txtAddsTerms.Text = "";
            txtPercentChanges.Text = "";
            txtBeginDate.Text = "";
            txtEndDate.Text = "";
            lblMessage.Visible = false;

            ToggleAllCheckboxes(rptPrograms, chkSelectAll, "chkProgram");
            ToggleAllCheckboxes(rptSpecialists, chkSelectAllSpecialists, "chkSpecialist");

            ListBox_Program_Inc.Items.Clear();
            ListBox_Program_Exc.Items.Clear();
            ListBox_Specialist_Inc.Items.Clear();
            ListBox_Specialist_Exc.Items.Clear();
        }

        private void ToggleAllCheckboxes(Repeater rptPrograms, CheckBox chkSelectAll, string v)
        {
            throw new NotImplementedException();
        }
    }
}
