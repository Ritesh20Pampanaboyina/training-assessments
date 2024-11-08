
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
            DataTable programs = dataAccess.GetPrograms();
            rptPrograms.DataSource = programs;
            rptPrograms.DataBind();

            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string selectedPrograms = GetSelectedPrograms();

            // Call the stored procedure with collected values
            dataAccess.SubmitAuditRequest(
                ddlAuditType.SelectedValue,
                ddlAuditType.SelectedValue,
                ddlEnrollmentSpecialist.SelectedValue,
                ddlDSU.SelectedValue,
                ddlGroups.SelectedValue,
                txtAddsTerms.Text,
                txtPercentChanges.Text,
                DateTime.Parse(txtBeginDate.Text),
                DateTime.Parse(txtEndDate.Text),
                selectedPrograms
            );

            lblMessage.Text = "Audit request submitted successfully!";
            lblMessage.Visible = true;
        }

        private string GetSelectedPrograms()
        {
            string selectedPrograms = "";
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox checkBox = (CheckBox)item.FindControl("chkProgram");
                if (checkBox.Checked)
                {
                    selectedPrograms += checkBox.Text + ";";
                }
            }
            return selectedPrograms.TrimEnd(';');
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlAuditType.SelectedIndex = 0;
            ddlEnrollmentSpecialist.SelectedIndex = 0;
            ddlDSU.SelectedIndex = 0;
            ddlGroups.SelectedIndex = 0;
            txtAddsTerms.Text = "";
            txtPercentChanges.Text = "";
            txtBeginDate.Text = "";
            txtEndDate.Text = "";
            lblMessage.Visible = false;

            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }
            chkSelectAll.Checked = true;
        }
    }
}

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
            DataTable programs = dataAccess.GetPrograms();
            rptPrograms.DataSource = programs;
            rptPrograms.DataBind();

            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string selectedPrograms = GetSelectedPrograms();

            // Call the stored procedure with collected values
            dataAccess.SubmitAuditRequest(
                ddlAuditType.SelectedValue, // Pass AuditfileType1
                ddlAuditType2.SelectedValue, // Pass AuditfileType2 separately
                ddlEnrollmentSpecialist.SelectedValue,
                ddlDSU.SelectedValue,
                ddlGroups.SelectedValue,
                txtAddsTerms.Text,
                txtPercentChanges.Text,
                DateTime.Parse(txtBeginDate.Text),
                DateTime.Parse(txtEndDate.Text),
                selectedPrograms
            );

            lblMessage.Text = "Audit request submitted successfully!";
            lblMessage.Visible = true;
        }

        private string GetSelectedPrograms()
        {
            string selectedPrograms = "";
            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox checkBox = (CheckBox)item.FindControl("chkProgram");
                if (checkBox.Checked)
                {
                    selectedPrograms += checkBox.Text + ";";
                }
            }
            return selectedPrograms.TrimEnd(';');
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlAuditType.SelectedIndex = 0;
            ddlAuditType2.SelectedIndex = 0; // Reset ddlAuditType2
            ddlEnrollmentSpecialist.SelectedIndex = 0;
            ddlDSU.SelectedIndex = 0;
            ddlGroups.SelectedIndex = 0;
            txtAddsTerms.Text = "";
            txtPercentChanges.Text = "";
            txtBeginDate.Text = "";
            txtEndDate.Text = "";
            lblMessage.Visible = false;

            foreach (RepeaterItem item in rptPrograms.Items)
            {
                CheckBox chkProgram = (CheckBox)item.FindControl("chkProgram");
                chkProgram.Checked = true;
            }
            chkSelectAll.Checked = true;
        }
    }
}



using System;
using System.Web.UI;

namespace Percentage_Enrollment_UI
{
    public partial class Percentage_Enrollment_UI : Page
    {
        private DataAccessLayer dataAccess = new DataAccessLayer();

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string selectedAuditType = ddlAuditType.SelectedValue;

            // Declare AuditFileType1 and AuditFileType2 variables
            string auditFileType1 = selectedAuditType;
            string auditFileType2 = ""; // Initially empty

            // Apply custom logic to differentiate the two based on the selected value
            if (selectedAuditType == "FOCUS")
            {
                // When FOCUS is selected, do not change AuditFileType2
                auditFileType1 = "FOCUS";  // Set AuditFileType1 to "FOCUS"
                auditFileType2 = "";  // Leave AuditFileType2 unchanged or null if needed
            }
            else if (selectedAuditType == "RANDOM")
            {
                // When RANDOM is selected, set AuditFileType2 to a specific value
                auditFileType1 = "RANDOM"; // Set AuditFileType1 to "RANDOM"
                auditFileType2 = "SPECIFIC"; // Set AuditFileType2 to "SPECIFIC" or any other value
            }

            // Call the data access method to submit the values for AuditFileType1 and AuditFileType2
            dataAccess.SubmitAuditRequest(
                auditFileType1,  // Set for AuditFileType1
                auditFileType2,  // Set for AuditFileType2 (can be left blank if FOCUS is selected)
                "", // Other fields as needed
                "", 
                "",
                "",
                "",
                DateTime.Now, // Placeholder for start date
                DateTime.Now, // Placeholder for end date
                "" // Placeholder for selected programs
            );

            lblMessage.Text = "Audit request submitted successfully!";
            lblMessage.Visible = true;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ddlAuditType.SelectedIndex = 0; // Reset to default value
            lblMessage.Visible = false;
        }
    }
}
