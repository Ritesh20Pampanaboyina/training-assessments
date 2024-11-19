using System;
using System.Web.UI;

namespace Percentage_Enrollment_UI
{
    public partial class WebForm_Percentage_Claim_UI : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckSubmissionStatus();
            }
        }

        private void CheckSubmissionStatus()
        {
            DataAccessLayer dal = new DataAccessLayer();
            bool isSubmitted = dal.CheckRecentSubmission();

            if (isSubmitted)
            {
                btnSubmit.CssClass = "btn-orange";
                btnSubmit.Enabled = true;
                lblStatus.Text = "Orange Submit button indicates a request was submitted in the last 30 minutes.";
            }
            else
            {
                btnSubmit.CssClass = "btn-green";
                btnSubmit.Enabled = true;
                lblStatus.Text = "Green Submit button indicates no request was submitted in the last 30 minutes.";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            DataAccessLayer dal = new DataAccessLayer();
            bool isSubmitted = dal.CheckRecentSubmission();

            if (isSubmitted)
            {
                lblStatus.Text = "Request already submitted in this 30 min slot. Do you want to overwrite?";
                // Proceed with overwriting if user confirms
                SubmitRequest(true);
            }
            else
            {
                SubmitRequest(false);
                lblStatus.Text = "Request submitted successfully!";
                CheckSubmissionStatus(); // Update button status
            }
        }

        private void SubmitRequest(bool overwrite)
        {
            DataAccessLayer dal = new DataAccessLayer();
            bool result = dal.SubmitAuditRequest(
                "FileType1",  // Example parameters; replace with actual values
                "DSU",
                "Groups",
                "AddsTerms",
                "PercentChanges",
                DateTime.Now.AddDays(-7),  // Example start date
                DateTime.Now,  // Example end date
                "IncludedPrograms",
                "ExcludedPrograms",
                "IncludedSpecialists",
                "ExcludedSpecialists"
            );

            if (result)
            {
                lblStatus.Text = overwrite ? "Request overwritten successfully." : "Request submitted successfully.";
            }
            else
            {
                lblStatus.Text = "An error occurred while submitting the request.";
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            CheckSubmissionStatus();
            lblStatus.Text = "Reset complete. You can now submit a new request.";
        }
    }
}
