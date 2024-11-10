using System;
using System.Data;
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
            }
        }

        private void LoadPrograms()
        {
            // Fetch programs from data source
            DataTable programs = dataAccess.GetPrograms();
            rptPrograms.DataSource = programs;
            rptPrograms.DataBind();

            // Set all checkboxes to checked by default
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }

            // Ensure the "Select All" checkbox is checked
            chkSelectAll.Checked = true;
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string includedPrograms = GetIncludedPrograms();
            string excludedPrograms = GetExcludedPrograms();

            // Ensure date values are provided and parse them
            DateTime startDate, endDate;
            if (!DateTime.TryParse(txtBeginDate.Text, out startDate))
            {
                lblMessage.Text = "Please enter a valid Begin Date.";
                lblMessage.Visible = true;
                return;
            }
            if (!DateTime.TryParse(txtEndDate.Text, out endDate))
            {
                lblMessage.Text = "Please enter a valid End Date.";
                lblMessage.Visible = true;
                return;
            }

            // Call the stored procedure with collected values
            dataAccess.SubmitAuditRequest(
                ddlAuditType.SelectedValue,  // For AuditFileType1
                ddlAuditType.SelectedValue,  // For AuditFileType2 (could be different if needed)
                ddlEnrollmentSpecialist.SelectedValue,
                ddlDSU.SelectedValue,
                ddlGroups.SelectedValue,
                txtAddsTerms.Text,
                txtPercentChanges.Text,
                startDate,  // Corrected variable name to startDate
                endDate,
                includedPrograms,
                excludedPrograms
            );

            lblMessage.Text = "Audit request submitted successfully!";
            lblMessage.Visible = true;
        }

        private string GetIncludedPrograms()
        {
            // Collect included programs based on checked items
            string includedPrograms = "";
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox checkBox = (CheckBox)item.FindControl("chkProgram");
                Label lblProgramId = (Label)item.FindControl("lblProgramId");
                if (checkBox != null && checkBox.Checked && lblProgramId != null)
                {
                    includedPrograms += lblProgramId.Text + ";";
                }
            }
            return includedPrograms.TrimEnd(';');
        }

        private string GetExcludedPrograms()
        {
            // Collect excluded programs based on unchecked items
            string excludedPrograms = "";
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox checkBox = (CheckBox)item.FindControl("chkProgram");
                Label lblProgramId = (Label)item.FindControl("lblProgramId");
                if (checkBox != null && !checkBox.Checked && lblProgramId != null)
                {
                    excludedPrograms += lblProgramId.Text + ";";
                }
            }
            return excludedPrograms.TrimEnd(';');
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Reset all controls to default values
            ddlAuditType.SelectedIndex = 0;
            ddlEnrollmentSpecialist.SelectedIndex = 0;
            ddlDSU.SelectedIndex = 0;
            ddlGroups.SelectedIndex = 0;
            txtAddsTerms.Text = "";
            txtPercentChanges.Text = "";
            txtBeginDate.Text = "";
            txtEndDate.Text = "";
            lblMessage.Visible = false;

            // Set all program checkboxes to checked
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }

            // Set "Select All" checkbox to checked
            chkSelectAll.Checked = true;
        }

        protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
        {
            // Check/uncheck all program checkboxes based on Select All status
            bool isChecked = chkSelectAll.Checked;
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = isChecked;
            }
        }
    }
}
