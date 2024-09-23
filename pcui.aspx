using Percentage_Claim_UI.DBUtilities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using log4net;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Text.RegularExpressions;
using Microsoft.Ajax.Utilities;

namespace Percentage_Claim_UI
{
    public partial class WebForm_Percentage_Claim_UI : System.Web.UI.Page
    {
        dbConnection PerCentageClaimdbcon = new dbConnection();
        ILog logger = LogManager.GetLogger(typeof(WebForm_Percentage_Claim_UI));
        string ClaimType; //Code Added on 04/02/2024(IDEA0060156)
        string ExtractType;
        string progids_Included,Progids_Excluded;
        string Adjudicators_Included, Adjudicators_Excluded;
        DateTime begin_date, end_date;
        string Providers_Included;
        string dxcodes_Included;
        string procodes_Included;
        string Poscodes_Included;
        string RuleIDs_Included;
        string Claim_Over_Dollar;
        string Number_Percent_Claim;
        string Check_Flag;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                clearPerCentageClaimSelection();
                loadAuditType("PostPay Claim");//Code Added on 04/02/2024(IDEA0060156)
                div_prepay_claim.Visible = false;//Code Added on 04/02/2024(IDEA0060156)
                div_postpay_claim.Visible = true;//Code Added on 04/02/2024(IDEA0060156)
                loadProgramNameandClaims();
                loadAdjudicators_PercentageClaim();
                lblMessage.Text = String.Empty;
                lblMessage.Visible = false;

                btnSearch_ProviderID.Enabled = false;
                ddlProviders_IncExc.Enabled = false;
                btnAdd_Providers.Enabled = false;

                btn_Search_dxCode.Enabled = false;
                ddl_dxCode_IncExc.Enabled = false;
                btnAdd_dxCode.Enabled = false;

                btnSearch_Proc.Enabled = false;
                ddl_ProcCode_IncExc.Enabled = false;
                btnAdd_ProcedureCode.Enabled = false;

                btn_Search_ServiceCode.Enabled = false;
                ddl_PosCode_IncExc.Enabled = false;
                btn_Add_ServiceCode.Enabled = false;

                btnSearch_ruleid.Enabled = false;
                ddl_RuleID_IncExc.Enabled = false;
                BtnAdd_RuleID.Enabled = false;

                ddl_AdjudiCators_IncExc.Enabled = false;
                BtnAdd_Adjudicators.Enabled = false;

                ddl_Program_IncExc.Enabled = false;
                BtnAdd_Program.Enabled = false;

                //Code Added on 08/07/2024 For Email Notification Change(Start)
                String Interfaceid = "";
                if (ddl_postpay_prepay_claim.SelectedItem.Text == "PostPay Claim")
                {
                    Interfaceid = "INT00000608";
                }
                else
                {
                    Interfaceid = "INT00000619";
                }

                try
                {
                    
                    DataTable dt_new  = PerCentageClaimdbcon.GetAdhocFlag(Interfaceid);
                    Check_Flag = dt_new.Rows[0][0].ToString();
                    if (Check_Flag == "T")
                    {
                        btnCheck.Visible = true;
                        btnSubmit.Visible = false;
                    }
                    else
                    {
                        btnCheck.Visible = false;
                        btnSubmit.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }
                //Code Added on 08/07/2024 For Email Notification Change(End)

            }
            else
            {
                //Code Added on 08/07/2024 For Email Notification Change(Start)
                String Interfaceid = "";
                if (ddl_postpay_prepay_claim.SelectedItem.Text == "PostPay Claim")
                {
                    Interfaceid = "INT00000608";
                }
                else
                {
                    Interfaceid = "INT00000619";
                }

                try
                {

                    DataTable dt_new = PerCentageClaimdbcon.GetAdhocFlag(Interfaceid);
                    Check_Flag = dt_new.Rows[0][0].ToString();
                    if (Check_Flag == "T")
                    {
                        btnCheck.Visible = true;
                        btnSubmit.Visible = false;
                    }
                    else
                    {
                        btnCheck.Visible = false;
                        btnSubmit.Visible = true;
                    }
                }
                catch (Exception ex)
                {
                    ex.Message.ToString();
                }
                //Code Added on 08/07/2024 For Email Notification Change(End)

            }
            //txt_begin_date.Text = DateTime.Now.ToString("MM-dd-yyyy");
            //txt_End_date.Text = DateTime.Now.ToString("MM-dd-yyyy");
        }
        public void clearPerCentageClaimSelection()
        {
            //txtMemberID.Text = "";
            txt_ProviderID.Text = "";
            txt_Procedurecode.Text = "";
            txt_dollar_claim.Text = "";
            txt_percent_claim.Text = "";
            lblMessage.Text = "";
            txt_ruleid.Text = "";
            txt_ServiceCode.Text = "";
            txt_dxCode.Text = "";
            txt_begin_date.Text = "";
            txt_End_date.Text = "";
            // Added to clear the date control values - C32-7302 
            dt_begin.SelectedDate = null;
            dt_end.SelectedDate = null;

            btnSearch_ProviderID.Enabled = false;
            ddlProviders_IncExc.Enabled = false;
            btnAdd_Providers.Enabled = false;

            btn_Search_dxCode.Enabled = false;
            ddl_dxCode_IncExc.Enabled = false;
            btnAdd_dxCode.Enabled = false;

            btnSearch_Proc.Enabled = false;
            ddl_ProcCode_IncExc.Enabled = false;
            btnAdd_ProcedureCode.Enabled = false;

            btn_Search_ServiceCode.Enabled = false;
            ddl_PosCode_IncExc.Enabled = false;
            btn_Add_ServiceCode.Enabled = false;

            btnSearch_ruleid.Enabled = false;
            ddl_RuleID_IncExc.Enabled = false;
            BtnAdd_RuleID.Enabled = false;

            ddl_AdjudiCators_IncExc.Enabled = false;
            BtnAdd_Adjudicators.Enabled = false;


            CheckBox_ClaimOver_Dollar.Checked = true;
            txt_dollar_claim.Visible = false;

            ddl_postpay_prepay_claim.SelectedIndex = 0;//Code Added on 04/02/2024(IDEA0060156)
            ddl_ExtractType.SelectedIndex = 0;//Code Added on 04/02/2024(IDEA0060156)
            loadAuditType("PostPay Claim");//Code Added on 04/02/2024(IDEA0060156)
            div_prepay_claim.Visible = false;//Code Added on 04/02/2024(IDEA0060156)
            div_postpay_claim.Visible = true;//Code Added on 04/02/2024(IDEA0060156)

            CheckBox_All_Programs.Checked = true;
            ddl_Program_IncExc.Enabled = false;
            BtnAdd_Program.Enabled = false;
            ListBox_Program_Inc.Items.Clear();
            ListBox_Program_Exc.Items.Clear();
            LinkButton_Program_Inc.Visible = false;
            LinkButton_Program_Exc.Visible = false;
            loadProgramNameandClaims();

            CheckBox_All_Adjudicators.Checked = true;
            ddl_AdjudiCators_IncExc.Enabled = false;
            BtnAdd_Adjudicators.Enabled = false;
            ListBox_Adjudicators_Inc.Items.Clear();
            ListBox_Adjudicators_Exc.Items.Clear();
            LinkButton_Adjudicators_Inc.Visible = false;
            LinkButton_Adjudicators_Exc.Visible = false;
            loadAdjudicators_PercentageClaim();

            chkAllProviders.Checked = true;
            ddlProviders_IncExc.Enabled = false;
            btnAdd_Providers.Enabled = false;
            ListBox_Providers_Inc.Items.Clear();
            //ListBox_Providers_Exc.Items.Clear();
            LinkButton_Providers_Inc.Visible = false;
            //LinkButton_Providers_Exc.Visible = false;
            pnlProviders.Visible = false;

            CheckBox_dxCode.Checked = true;
            ddl_dxCode_IncExc.Enabled = false;
            btnAdd_dxCode.Enabled = false;
            ListBox_dxCode_Inc.Items.Clear();
            //ListBox_dxCode_Exc.Items.Clear();
            LinkButton_dxCode_Inc.Visible = false;
            //LinkButton_dxCode_Exc.Visible = false;
            PnldxCodes.Visible = false;

            chkAllProcCode.Checked = true;
            ddl_ProcCode_IncExc.Enabled = false;
            btnAdd_ProcedureCode.Enabled = false;
            ListBox_ProcCode_Inc.Items.Clear();
            //ListBox_ProcCode_Exc.Items.Clear();
            LinkButton_ProcCode_Inc.Visible = false;
            //LinkButton_ProcCode_Exc.Visible = false;
            pnlProcedures.Visible = false;

            CheckBox_ServiceCode.Checked = true;
            ddl_PosCode_IncExc.Enabled = false;
            btn_Add_ServiceCode.Enabled = false;
            ListBox_ServiceCode_Inc.Items.Clear();
            //ListBox_ServiceCode_Exc.Items.Clear();
            LinkButton_ServiceCode_Inc.Visible = false;
            //LinkButton_ServiceCode_Exc.Visible = false;
            PnlPosCode.Visible = false;

            CheckBox_All_Ruleid.Checked = true;
            ddl_RuleID_IncExc.Enabled = false;
            BtnAdd_RuleID.Enabled = false;
            ListBox_RuleID_Inc.Items.Clear();
            //ListBox_RuleID_Exc.Items.Clear();
            LinkButton_RuleID_Inc.Visible = false;
            //LinkButton_RuleID_Exc.Visible = false;
            Pnl_RuleID.Visible = false;
            //Code Added on 08/07/2024 For Email Notification Change(Start)
            main_Panel.Enabled = true;
            lblMessage.Visible = false;
            
            String Interfaceid = "";
            if (ddl_postpay_prepay_claim.SelectedItem.Text == "PostPay Claim")
            {
                Interfaceid = "INT00000608";
            }
            else
            {
                Interfaceid = "INT00000619";
            }

            try
            {

                DataTable dt_new = PerCentageClaimdbcon.GetAdhocFlag(Interfaceid);
                Check_Flag = dt_new.Rows[0][0].ToString();
                if (Check_Flag == "T")
                {
                    btnCheck.Visible = true;
                    btnSubmit.Visible = false;
                }
                else
                {
                    btnCheck.Visible = false;
                    btnSubmit.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
            }
            //Code Added on 08/07/2024 For Email Notification Change(Start)


        }
        private void loadAuditType(string claim_type)//Code Added on 04/02/2024(IDEA0060156)
        {
            try
            {
                DataSet dsAuditType = new DataSet();
                dsAuditType = PerCentageClaimdbcon.getAuditType(claim_type);//Code Added on 04/02/2024(IDEA0060156)
                if (dsAuditType.Tables.Count > 0)
                {
                    if (dsAuditType.Tables[0].Rows.Count > 0)
                    {
                        ddl_ExtractType.DataSource = dsAuditType.Tables[0];
                        ddl_ExtractType.DataTextField = "AuditType";
                        ddl_ExtractType.DataValueField = "AuditType";
                        ddl_ExtractType.DataBind();
                        ddl_ExtractType.SelectedIndex = 0;
                    }

                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message.ToString();
                logger.Error(ex.Message);
            }
        }
        private void loadProgramNameandClaims()
        {
            try
            {
                DataSet dsProgramClaims = new DataSet();
                dsProgramClaims = PerCentageClaimdbcon.getProgramClaimDetails();
                if (dsProgramClaims.Tables.Count > 0)
                {
                    if (dsProgramClaims.Tables[0].Rows.Count > 0)
                    {
                        chkProgramname.DataSource = dsProgramClaims.Tables[0];
                        chkProgramname.DataTextField = "programid";
                        chkProgramname.DataValueField = "programid";
                        chkProgramname.DataBind();
                    }
                   
                }
                if (CheckBox_All_Programs.Checked == true)
                {
                    foreach (ListItem l in chkProgramname.Items)
                    {
                        l.Selected = true;
                    }
                }
                else
                {
                    foreach (ListItem l in chkProgramname.Items)
                    {
                        l.Selected = false;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message.ToString();
                logger.Error(ex.Message);
            }
        }
        
         private void loadAdjudicators_PercentageClaim()
        {
            try
            {
                DataSet dsAdjudicators = new DataSet();
                dsAdjudicators = PerCentageClaimdbcon.GetAdjudicators_PercentageClaim();
                if (dsAdjudicators.Tables.Count > 0)
                {
                    if (dsAdjudicators.Tables[0].Rows.Count > 0)
                    {
                        CheckBoxList_Adjudicators.DataSource = dsAdjudicators.Tables[0];
                        CheckBoxList_Adjudicators.DataTextField = "op_user";
                        CheckBoxList_Adjudicators.DataValueField = "op_user";
                        CheckBoxList_Adjudicators.DataBind();
                    }

                }
                if (CheckBox_All_Adjudicators.Checked == true)
                {
                    foreach (ListItem l in CheckBoxList_Adjudicators.Items)
                    {
                        l.Selected = true;
                    }
                }
                else
                {
                    foreach (ListItem l in CheckBoxList_Adjudicators.Items)
                    {
                        l.Selected = false;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message.ToString();
                logger.Error(ex.Message);
            }
        }

        protected void chkAllProviders_CheckedChanged(object sender, EventArgs e)
        {
            if (chkAllProviders.Checked == false)
            {
                btnSearch_ProviderID.Enabled = true;
                ddlProviders_IncExc.Enabled = true;
                btnAdd_Providers.Enabled = true;
                ListBox_Providers_Inc.Enabled = true;
                ListBox_Providers_Exc.Enabled = true;
            }
            else
            {
                btnSearch_ProviderID.Enabled = false;
                ddlProviders_IncExc.Enabled = false;
                btnAdd_Providers.Enabled = false;
                ListBox_Providers_Inc.Enabled = false;
                ListBox_Providers_Exc.Enabled = false;
                pnlProviders.Visible = false;
                LinkButton_Providers_Inc.Visible = false;
                LinkButton_Providers_Exc.Visible = false;
                ListBox_Providers_Inc.Items.Clear();
                ListBox_Providers_Exc.Items.Clear();
            }
        }

        protected void btnSearch_ProviderID_Click(object sender, EventArgs e)
        {
            try
            {
                if (txt_ProviderID.Text != "")
                {
                    if (CheckBoxList_Providers.Items.Count > 0)
                        CheckBoxList_Providers.Items.Clear();
                    bindProviders(txt_ProviderID.Text);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Error occured while searching for the providers. Please contact support team.";
                logger.Error("Error occured while searching for the providers :" + ex.Message);
            }
        }

        private void bindProviders(string providername)
        {
            try
            {
                if (txt_ProviderID.Text != "")
                {
                    DataTable dtProviders = PerCentageClaimdbcon.getProviders(providername);
                    if (dtProviders.Rows.Count > 0)
                    {
                        pnlProviders.Visible = true;
                        CheckBoxList_Providers.Visible = true;
                        CheckBoxList_Providers.DataTextField = "fullname";
                        CheckBoxList_Providers.DataValueField = "provid";
                        CheckBoxList_Providers.DataSource = dtProviders;
                        CheckBoxList_Providers.DataBind();
                    }

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void btnAdd_Providers_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_Providers.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddlProviders_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_Providers_Inc.Items.Count == 0)
                            {
                                if (ListBox_Providers_Exc.Items.Count > 0)
                                {
                                    if (ListBox_Providers_Inc.Items.Contains(lst) == false && ListBox_Providers_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Providers_Inc.DataTextField = lst.Text;
                                        ListBox_Providers_Inc.DataValueField = lst.Value;
                                        ListBox_Providers_Inc.Items.Add(lst);
                                        LinkButton_Providers_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_Providers_Inc.DataTextField = lst.Text;
                                    ListBox_Providers_Inc.DataValueField = lst.Value;
                                    ListBox_Providers_Inc.Items.Add(lst);
                                    LinkButton_Providers_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_Providers_Inc.Items.Contains(lst) == false && ListBox_Providers_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Providers_Inc.DataTextField = lst.Text;
                                    ListBox_Providers_Inc.DataValueField = lst.Value;
                                    ListBox_Providers_Inc.Items.Add(lst);
                                    LinkButton_Providers_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddlProviders_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_Providers_Exc.Items.Count == 0)
                            {
                                if (ListBox_Providers_Inc.Items.Count > 0)
                                {
                                    if (ListBox_Providers_Exc.Items.Contains(lst) == false && ListBox_Providers_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Providers_Exc.DataTextField = lst.Text;
                                        ListBox_Providers_Exc.DataValueField = lst.Value;
                                        ListBox_Providers_Exc.Items.Add(lst);
                                        //LinkButton_Providers_Exc.Visible = true;
                                        LinkButton_Providers_Exc.Visible = false;
                                    }
                                }
                                else
                                {
                                    ListBox_Providers_Exc.DataTextField = lst.Text;
                                    ListBox_Providers_Exc.DataValueField = lst.Value;
                                    ListBox_Providers_Exc.Items.Add(lst);
                                    //LinkButton_Providers_Exc.Visible = true;
                                    LinkButton_Providers_Exc.Visible = false;
                                }
                            }
                            else
                            {
                                if (ListBox_Providers_Inc.Items.Contains(lst) == false && ListBox_Providers_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Providers_Exc.DataTextField = lst.Text;
                                    ListBox_Providers_Exc.DataValueField = lst.Value;
                                    ListBox_Providers_Exc.Items.Add(lst);
                                    //LinkButton_Providers_Exc.Visible = true;
                                    LinkButton_Providers_Exc.Visible = false;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding Providers. Please contact support team.";
                logger.Error("Error occured while adding Providers : " + ex.Message);
            }
        }

        protected void ListBox_Providers_Inc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Providers_Inc.Items.Count > 0)
                {
                    LinkButton_Providers_Inc.Visible = true;
                }
            }
        }

        protected void ListBox_Providers_Exc_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Providers_Exc.Items.Count > 0)
                {
                    //LinkButton_Providers_Exc.Visible = true;
                    LinkButton_Providers_Exc.Visible = false;
                }

            }
        }

        protected void LinkButton_Providers_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Providers_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProviderRemoveInc in ListBox_Providers_Inc.Items)
                    {
                        if (lstProviderRemoveInc.Selected == true)
                            deleteditems.Add(lstProviderRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Providers_Inc.Items.Remove(item);
                    }
                    if (ListBox_Providers_Inc.Items.Count == 0)
                    {
                        LinkButton_Providers_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_Providers_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Providers_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProvRemoveExc in ListBox_Providers_Exc.Items)
                    {
                        if (lstProvRemoveExc.Selected == true)
                            deleteditems.Add(lstProvRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Providers_Exc.Items.Remove(item);
                    }
                    if (ListBox_Providers_Exc.Items.Count == 0)
                    {
                        LinkButton_Providers_Exc.Visible = false;
                    }
                }
            }
        }

        protected void btn_Search_dxCode_Click(object sender, EventArgs e)
        {
            try
            {
                if (txt_dxCode.Text != "")
                {
                    if (CheckBoxList_dxCode.Items.Count > 0)
                        CheckBoxList_dxCode.Items.Clear();
                    binddxCode(txt_dxCode.Text);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Error occured while searching for the providers. Please contact support team.";
                logger.Error("Error occured while searching for the providers :" + ex.Message);
            }
        }
        private void binddxCode(string dxcode)
        {
            try
            {
                if (txt_dxCode.Text != "")
                {
                    DataTable dtdxcodes = PerCentageClaimdbcon.getdxcodes(dxcode);
                    if (dtdxcodes.Rows.Count > 0)
                    {
                        PnldxCodes.Visible = true;
                        CheckBoxList_dxCode.Visible = true;
                        CheckBoxList_dxCode.DataTextField = "codeid";
                        CheckBoxList_dxCode.DataValueField = "codeid";
                        CheckBoxList_dxCode.DataSource = dtdxcodes;
                        CheckBoxList_dxCode.DataBind();
                    }

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void CheckBox_dxCode_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_dxCode.Checked == false)
            {
                btn_Search_dxCode.Enabled = true;
                ddl_dxCode_IncExc.Enabled = true;
                btnAdd_dxCode.Enabled = true;
                ListBox_dxCode_Inc.Enabled = true;
                ListBox_dxCode_Exc.Enabled = true;
            }
            else
            {
                btn_Search_dxCode.Enabled = false;
                ddl_dxCode_IncExc.Enabled = false;
                btnAdd_dxCode.Enabled = false;
                ListBox_dxCode_Inc.Enabled = false;
                ListBox_dxCode_Exc.Enabled = false;
                PnldxCodes.Visible = false;
                LinkButton_dxCode_Inc.Visible = false;
                LinkButton_dxCode_Exc.Visible = false;
                ListBox_dxCode_Inc.Items.Clear();
                ListBox_dxCode_Exc.Items.Clear();
            }
        }

        protected void btnAdd_dxCode_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_dxCode.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_dxCode_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_dxCode_Inc.Items.Count == 0)
                            {
                                if (ListBox_dxCode_Exc.Items.Count > 0)
                                {
                                    if (ListBox_dxCode_Inc.Items.Contains(lst) == false && ListBox_dxCode_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_dxCode_Inc.DataTextField = lst.Text;
                                        ListBox_dxCode_Inc.DataValueField = lst.Value;
                                        ListBox_dxCode_Inc.Items.Add(lst);
                                        LinkButton_dxCode_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_dxCode_Inc.DataTextField = lst.Text;
                                    ListBox_dxCode_Inc.DataValueField = lst.Value;
                                    ListBox_dxCode_Inc.Items.Add(lst);
                                    LinkButton_dxCode_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_dxCode_Inc.Items.Contains(lst) == false && ListBox_dxCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_dxCode_Inc.DataTextField = lst.Text;
                                    ListBox_dxCode_Inc.DataValueField = lst.Value;
                                    ListBox_dxCode_Inc.Items.Add(lst);
                                    LinkButton_dxCode_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddl_dxCode_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_dxCode_Exc.Items.Count == 0)
                            {
                                if (ListBox_dxCode_Inc.Items.Count > 0)
                                {
                                    if (ListBox_dxCode_Exc.Items.Contains(lst) == false && ListBox_dxCode_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_dxCode_Exc.DataTextField = lst.Text;
                                        ListBox_dxCode_Exc.DataValueField = lst.Value;
                                        ListBox_dxCode_Exc.Items.Add(lst);
                                        //LinkButton_dxCode_Exc.Visible = true;
                                        LinkButton_dxCode_Exc.Visible = false;
                                    }
                                }
                                else
                                {
                                    ListBox_dxCode_Exc.DataTextField = lst.Text;
                                    ListBox_dxCode_Exc.DataValueField = lst.Value;
                                    ListBox_dxCode_Exc.Items.Add(lst);
                                    //LinkButton_dxCode_Exc.Visible = true;
                                    LinkButton_dxCode_Exc.Visible = false;
                                }
                            }
                            else
                            {
                                if (ListBox_dxCode_Inc.Items.Contains(lst) == false && ListBox_dxCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_dxCode_Exc.DataTextField = lst.Text;
                                    ListBox_dxCode_Exc.DataValueField = lst.Value;
                                    ListBox_dxCode_Exc.Items.Add(lst);
                                    //LinkButton_dxCode_Exc.Visible = true;
                                    LinkButton_dxCode_Exc.Visible = false;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding Providers. Please contact support team.";
                logger.Error("Error occured while adding Providers : " + ex.Message);
            }
        }

        protected void LinkButton_dxCode_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_dxCode_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstdxcodeRemoveInc in ListBox_dxCode_Inc.Items)
                    {
                        if (lstdxcodeRemoveInc.Selected == true)
                            deleteditems.Add(lstdxcodeRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_dxCode_Inc.Items.Remove(item);
                    }
                    if (ListBox_dxCode_Inc.Items.Count == 0)
                    {
                        LinkButton_dxCode_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_dxCode_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_dxCode_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstdxcodeRemoveExc in ListBox_dxCode_Exc.Items)
                    {
                        if (lstdxcodeRemoveExc.Selected == true)
                            deleteditems.Add(lstdxcodeRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_dxCode_Exc.Items.Remove(item);
                    }
                    if (ListBox_dxCode_Exc.Items.Count == 0)
                    {
                        LinkButton_dxCode_Exc.Visible = false;
                    }
                }
            }
        }

        protected void btnSearch_Proc_Click(object sender, EventArgs e)
        {
            try
            {
                if (txt_Procedurecode.Text != "")
                {
                    if (CheckBoxList_ProcCode.Items.Count > 0)
                        CheckBoxList_ProcCode.Items.Clear();
                    bindProcCode(txt_Procedurecode.Text);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Error occured while searching for the providers. Please contact support team.";
                logger.Error("Error occured while searching for the providers :" + ex.Message);
            }
        }
        private void bindProcCode(string Proccode)
        {
            try
            {
                if (txt_Procedurecode.Text != "")
                {
                    DataTable dtProccodes = PerCentageClaimdbcon.getProcedureCodes(Proccode);
                    if (dtProccodes.Rows.Count > 0)
                    {
                        pnlProcedures.Visible = true;
                        CheckBoxList_ProcCode.Visible = true;
                        CheckBoxList_ProcCode.DataTextField = "codeid";
                        CheckBoxList_ProcCode.DataValueField = "codeid";
                        CheckBoxList_ProcCode.DataSource = dtProccodes;
                        CheckBoxList_ProcCode.DataBind();
                    }

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void chkAllProcCode_CheckedChanged(object sender, EventArgs e)
        {
            if (chkAllProcCode.Checked == false)
            {
                btnSearch_Proc.Enabled = true;
                ddl_ProcCode_IncExc.Enabled = true;
                btnAdd_ProcedureCode.Enabled = true;
                ListBox_ProcCode_Inc.Enabled = true;
                ListBox_ProcCode_Exc.Enabled = true;
            }
            else
            {
                btnSearch_Proc.Enabled = false;
                ddl_ProcCode_IncExc.Enabled = false;
                btnAdd_ProcedureCode.Enabled = false;
                ListBox_ProcCode_Inc.Enabled = false;
                ListBox_ProcCode_Exc.Enabled = false;
                pnlProcedures.Visible = false;
                LinkButton_ProcCode_Inc.Visible = false;
                LinkButton_ProcCode_Exc.Visible = false;
                ListBox_ProcCode_Inc.Items.Clear();
                ListBox_ProcCode_Exc.Items.Clear();
            }
        }

        protected void btnAdd_ProcedureCode_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_ProcCode.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_ProcCode_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_ProcCode_Inc.Items.Count == 0)
                            {
                                if (ListBox_ProcCode_Exc.Items.Count > 0)
                                {
                                    if (ListBox_ProcCode_Inc.Items.Contains(lst) == false && ListBox_ProcCode_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_ProcCode_Inc.DataTextField = lst.Text;
                                        ListBox_ProcCode_Inc.DataValueField = lst.Value;
                                        ListBox_ProcCode_Inc.Items.Add(lst);
                                        LinkButton_ProcCode_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_ProcCode_Inc.DataTextField = lst.Text;
                                    ListBox_ProcCode_Inc.DataValueField = lst.Value;
                                    ListBox_ProcCode_Inc.Items.Add(lst);
                                    LinkButton_ProcCode_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_ProcCode_Inc.Items.Contains(lst) == false && ListBox_ProcCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_ProcCode_Inc.DataTextField = lst.Text;
                                    ListBox_ProcCode_Inc.DataValueField = lst.Value;
                                    ListBox_ProcCode_Inc.Items.Add(lst);
                                    LinkButton_ProcCode_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddl_ProcCode_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_ProcCode_Exc.Items.Count == 0)
                            {
                                if (ListBox_ProcCode_Inc.Items.Count > 0)
                                {
                                    if (ListBox_ProcCode_Exc.Items.Contains(lst) == false && ListBox_ProcCode_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_ProcCode_Exc.DataTextField = lst.Text;
                                        ListBox_ProcCode_Exc.DataValueField = lst.Value;
                                        ListBox_ProcCode_Exc.Items.Add(lst);
                                        //LinkButton_ProcCode_Exc.Visible = true;
                                        LinkButton_ProcCode_Exc.Visible = false;
                                    }
                                }
                                else
                                {
                                    ListBox_ProcCode_Exc.DataTextField = lst.Text;
                                    ListBox_ProcCode_Exc.DataValueField = lst.Value;
                                    ListBox_ProcCode_Exc.Items.Add(lst);
                                    //LinkButton_ProcCode_Exc.Visible = true;
                                    LinkButton_ProcCode_Exc.Visible = false;
                                }
                            }
                            else
                            {
                                if (ListBox_ProcCode_Inc.Items.Contains(lst) == false && ListBox_ProcCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_ProcCode_Exc.DataTextField = lst.Text;
                                    ListBox_ProcCode_Exc.DataValueField = lst.Value;
                                    ListBox_ProcCode_Exc.Items.Add(lst);
                                    //LinkButton_ProcCode_Exc.Visible = true;
                                    LinkButton_ProcCode_Exc.Visible = false;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding Providers. Please contact support team.";
                logger.Error("Error occured while adding Providers : " + ex.Message);
            }
        }

        protected void LinkButton_ProcCode_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_ProcCode_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProccodeRemoveInc in ListBox_ProcCode_Inc.Items)
                    {
                        if (lstProccodeRemoveInc.Selected == true)
                            deleteditems.Add(lstProccodeRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_ProcCode_Inc.Items.Remove(item);
                    }
                    if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        LinkButton_ProcCode_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_ProcCode_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_ProcCode_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProccodeRemoveExc in ListBox_ProcCode_Exc.Items)
                    {
                        if (lstProccodeRemoveExc.Selected == true)
                            deleteditems.Add(lstProccodeRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_ProcCode_Exc.Items.Remove(item);
                    }
                    if (ListBox_ProcCode_Exc.Items.Count == 0)
                    {
                        LinkButton_ProcCode_Exc.Visible = false;
                    }
                }
            }
        }

        protected void btn_Search_ServiceCode_Click(object sender, EventArgs e)
        {
            try
            {
                if (txt_ServiceCode.Text != "")
                {
                    if (CheckBoxList_ServiceCode.Items.Count > 0)
                        CheckBoxList_ServiceCode.Items.Clear();
                    bindPosCode(txt_ServiceCode.Text);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Error occured while searching for the POS Code. Please contact support team.";
                logger.Error("Error occured while searching for the POS Code :" + ex.Message);
            }
        }
        private void bindPosCode(string Poscode)
        {
            try
            {
                if (txt_ServiceCode.Text != "")
                {
                    DataTable dtPoscodes = PerCentageClaimdbcon.getPosCode(Poscode);
                    if (dtPoscodes.Rows.Count > 0)
                    {
                        PnlPosCode.Visible = true;
                        CheckBoxList_ServiceCode.Visible = true;
                        CheckBoxList_ServiceCode.DataTextField = "locationcode";
                        CheckBoxList_ServiceCode.DataValueField = "locationcode";
                        CheckBoxList_ServiceCode.DataSource = dtPoscodes;
                        CheckBoxList_ServiceCode.DataBind();
                    }

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void CheckBox_ServiceCode_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_ServiceCode.Checked == false)
            {
                btn_Search_ServiceCode.Enabled = true;
                ddl_PosCode_IncExc.Enabled = true;
                btn_Add_ServiceCode.Enabled = true;
                ListBox_ServiceCode_Inc.Enabled = true;
                ListBox_ServiceCode_Exc.Enabled = true;
            }
            else
            {
                btn_Search_ServiceCode.Enabled = false;
                ddl_PosCode_IncExc.Enabled = false;
                btn_Add_ServiceCode.Enabled = false;
                ListBox_ServiceCode_Inc.Enabled = false;
                ListBox_ServiceCode_Exc.Enabled = false;
                PnlPosCode.Visible = false;
                LinkButton_ServiceCode_Inc.Visible = false;
                LinkButton_ServiceCode_Exc.Visible = false;
                ListBox_ServiceCode_Inc.Items.Clear();
                ListBox_ServiceCode_Exc.Items.Clear();
            }
        }

        protected void btn_Add_ServiceCode_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_ServiceCode.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_PosCode_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_ServiceCode_Inc.Items.Count == 0)
                            {
                                if (ListBox_ServiceCode_Exc.Items.Count > 0)
                                {
                                    if (ListBox_ServiceCode_Inc.Items.Contains(lst) == false && ListBox_ServiceCode_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_ServiceCode_Inc.DataTextField = lst.Text;
                                        ListBox_ServiceCode_Inc.DataValueField = lst.Value;
                                        ListBox_ServiceCode_Inc.Items.Add(lst);
                                        LinkButton_ServiceCode_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_ServiceCode_Inc.DataTextField = lst.Text;
                                    ListBox_ServiceCode_Inc.DataValueField = lst.Value;
                                    ListBox_ServiceCode_Inc.Items.Add(lst);
                                    LinkButton_ServiceCode_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_ServiceCode_Inc.Items.Contains(lst) == false && ListBox_ServiceCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_ServiceCode_Inc.DataTextField = lst.Text;
                                    ListBox_ServiceCode_Inc.DataValueField = lst.Value;
                                    ListBox_ServiceCode_Inc.Items.Add(lst);
                                    LinkButton_ServiceCode_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddl_PosCode_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_ServiceCode_Exc.Items.Count == 0)
                            {
                                if (ListBox_ServiceCode_Exc.Items.Count > 0)
                                {
                                    if (ListBox_ServiceCode_Exc.Items.Contains(lst) == false && ListBox_ProcCode_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_ServiceCode_Exc.DataTextField = lst.Text;
                                        ListBox_ServiceCode_Exc.DataValueField = lst.Value;
                                        ListBox_ServiceCode_Exc.Items.Add(lst);
                                        //LinkButton_ServiceCode_Exc.Visible = true;
                                        LinkButton_ServiceCode_Exc.Visible = false;
                                    }
                                }
                                else
                                {
                                    ListBox_ServiceCode_Exc.DataTextField = lst.Text;
                                    ListBox_ServiceCode_Exc.DataValueField = lst.Value;
                                    ListBox_ServiceCode_Exc.Items.Add(lst);
                                    //LinkButton_ServiceCode_Exc.Visible = true;
                                    LinkButton_ServiceCode_Exc.Visible = false;
                                }
                            }
                            else
                            {
                                if (ListBox_ServiceCode_Inc.Items.Contains(lst) == false && ListBox_ServiceCode_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_ServiceCode_Exc.DataTextField = lst.Text;
                                    ListBox_ServiceCode_Exc.DataValueField = lst.Value;
                                    ListBox_ServiceCode_Exc.Items.Add(lst);
                                    //LinkButton_ServiceCode_Exc.Visible = true;
                                    LinkButton_ServiceCode_Exc.Visible = false;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding POS Codes. Please contact support team.";
                logger.Error("Error occured while adding POS Codes : " + ex.Message);
            }
        }

        protected void LinkButton_ServiceCode_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_ServiceCode_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstPoscodeRemoveInc in ListBox_ServiceCode_Inc.Items)
                    {
                        if (lstPoscodeRemoveInc.Selected == true)
                            deleteditems.Add(lstPoscodeRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_ServiceCode_Inc.Items.Remove(item);
                    }
                    if (ListBox_ServiceCode_Inc.Items.Count == 0)
                    {
                        LinkButton_ServiceCode_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_ServiceCode_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_ServiceCode_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstPoscodeRemoveExc in ListBox_ServiceCode_Exc.Items)
                    {
                        if (lstPoscodeRemoveExc.Selected == true)
                            deleteditems.Add(lstPoscodeRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_ServiceCode_Exc.Items.Remove(item);
                    }
                    if (ListBox_ServiceCode_Exc.Items.Count == 0)
                    {
                        LinkButton_ServiceCode_Exc.Visible = false;
                    }
                }
            }
        }

        protected void BtnAdd_Adjudicators_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_Adjudicators.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_AdjudiCators_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_Adjudicators_Inc.Items.Count == 0)
                            {
                                if (ListBox_Adjudicators_Exc.Items.Count > 0)
                                {
                                    if (ListBox_Adjudicators_Inc.Items.Contains(lst) == false && ListBox_Adjudicators_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Adjudicators_Inc.DataTextField = lst.Text;
                                        ListBox_Adjudicators_Inc.DataValueField = lst.Value;
                                        ListBox_Adjudicators_Inc.Items.Add(lst);
                                        LinkButton_Adjudicators_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_Adjudicators_Inc.DataTextField = lst.Text;
                                    ListBox_Adjudicators_Inc.DataValueField = lst.Value;
                                    ListBox_Adjudicators_Inc.Items.Add(lst);
                                    LinkButton_Adjudicators_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_Adjudicators_Inc.Items.Contains(lst) == false && ListBox_Adjudicators_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Adjudicators_Inc.DataTextField = lst.Text;
                                    ListBox_Adjudicators_Inc.DataValueField = lst.Value;
                                    ListBox_Adjudicators_Inc.Items.Add(lst);
                                    LinkButton_Adjudicators_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddl_AdjudiCators_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_Adjudicators_Exc.Items.Count == 0)
                            {
                                if (ListBox_Adjudicators_Inc.Items.Count > 0)
                                {
                                    if (ListBox_Adjudicators_Exc.Items.Contains(lst) == false && ListBox_Adjudicators_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Adjudicators_Exc.DataTextField = lst.Text;
                                        ListBox_Adjudicators_Exc.DataValueField = lst.Value;
                                        ListBox_Adjudicators_Exc.Items.Add(lst);
                                        LinkButton_Adjudicators_Exc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_Adjudicators_Exc.DataTextField = lst.Text;
                                    ListBox_Adjudicators_Exc.DataValueField = lst.Value;
                                    ListBox_Adjudicators_Exc.Items.Add(lst);
                                    LinkButton_Adjudicators_Exc.Visible = true;
                                }
                            }
                            else
                            {
                                if (ListBox_Adjudicators_Inc.Items.Contains(lst) == false && ListBox_Adjudicators_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Adjudicators_Exc.DataTextField = lst.Text;
                                    ListBox_Adjudicators_Exc.DataValueField = lst.Value;
                                    ListBox_Adjudicators_Exc.Items.Add(lst);
                                    LinkButton_Adjudicators_Exc.Visible = true;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding Adjudicators. Please contact support team.";
                logger.Error("Error occured while adding Adjudicators : " + ex.Message);
            }
        }

        protected void LinkButton_Adjudicators_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Adjudicators_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstAdjudicatorRemoveInc in ListBox_Adjudicators_Inc.Items)
                    {
                        if (lstAdjudicatorRemoveInc.Selected == true)
                            deleteditems.Add(lstAdjudicatorRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Adjudicators_Inc.Items.Remove(item);
                    }
                    if (ListBox_Adjudicators_Inc.Items.Count == 0)
                    {
                        LinkButton_Adjudicators_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_Adjudicators_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Adjudicators_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstAdjudicatorRemoveExc in ListBox_Adjudicators_Exc.Items)
                    {
                        if (lstAdjudicatorRemoveExc.Selected == true)
                            deleteditems.Add(lstAdjudicatorRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Adjudicators_Exc.Items.Remove(item);
                    }
                    if (ListBox_Adjudicators_Exc.Items.Count == 0)
                    {
                        LinkButton_Adjudicators_Exc.Visible = false;
                    }
                }
            }
        }

        protected void CheckBox_All_Adjudicators_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_All_Adjudicators.Checked == false)
            {
                
                ddl_AdjudiCators_IncExc.Enabled = true;
                BtnAdd_Adjudicators.Enabled = true;
                ListBox_Adjudicators_Inc.Enabled = true;
                ListBox_Adjudicators_Exc.Enabled = true;
               
                foreach (ListItem l in CheckBoxList_Adjudicators.Items)
                    {
                        l.Selected = false;
                    }
                
            }
            else
            {
                ddl_AdjudiCators_IncExc.Enabled = false;
                BtnAdd_Adjudicators.Enabled = false;
                ListBox_Adjudicators_Inc.Enabled = false;
                ListBox_Adjudicators_Exc.Enabled = false;
                //Panel_Adjudicators.Visible = false;
                LinkButton_Adjudicators_Inc.Visible = false;
                LinkButton_Adjudicators_Exc.Visible = false;
                ListBox_Adjudicators_Inc.Items.Clear();
                ListBox_Adjudicators_Exc.Items.Clear();
                
                    foreach (ListItem l in CheckBoxList_Adjudicators.Items)
                    {
                        l.Selected = true;
                    }
                
            }
        }

        protected void BtnAdd_Program_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in chkProgramname.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_Program_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_Program_Inc.Items.Count == 0)
                            {
                                if (ListBox_Program_Exc.Items.Count > 0)
                                {
                                    if (ListBox_Program_Inc.Items.Contains(lst) == false && ListBox_Program_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Program_Inc.DataTextField = lst.Text;
                                        ListBox_Program_Inc.DataValueField = lst.Value;
                                        ListBox_Program_Inc.Items.Add(lst);
                                        LinkButton_Program_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_Program_Inc.DataTextField = lst.Text;
                                    ListBox_Program_Inc.DataValueField = lst.Value;
                                    ListBox_Program_Inc.Items.Add(lst);
                                    LinkButton_Program_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_Program_Inc.Items.Contains(lst) == false && ListBox_Program_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Program_Inc.DataTextField = lst.Text;
                                    ListBox_Program_Inc.DataValueField = lst.Value;
                                    ListBox_Program_Inc.Items.Add(lst);
                                    LinkButton_Program_Inc.Visible = true;
                                }
                            }
                        }
                        else if (ddl_Program_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_Program_Exc.Items.Count == 0)
                            {
                                if (ListBox_Program_Inc.Items.Count > 0)
                                {
                                    if (ListBox_Program_Exc.Items.Contains(lst) == false && ListBox_Program_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_Program_Exc.DataTextField = lst.Text;
                                        ListBox_Program_Exc.DataValueField = lst.Value;
                                        ListBox_Program_Exc.Items.Add(lst);
                                        LinkButton_Program_Exc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_Program_Exc.DataTextField = lst.Text;
                                    ListBox_Program_Exc.DataValueField = lst.Value;
                                    ListBox_Program_Exc.Items.Add(lst);
                                    LinkButton_Program_Exc.Visible = true;
                                }
                            }
                            else
                            {
                                if (ListBox_Program_Inc.Items.Contains(lst) == false && ListBox_Program_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_Program_Exc.DataTextField = lst.Text;
                                    ListBox_Program_Exc.DataValueField = lst.Value;
                                    ListBox_Program_Exc.Items.Add(lst);
                                    LinkButton_Program_Exc.Visible = true;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding Programs. Please contact support team.";
                logger.Error("Error occured while adding Programs : " + ex.Message);
            }
        }

        protected void CheckBox_All_Programs_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_All_Programs.Checked == false)
            {

                ddl_Program_IncExc.Enabled = true;
                BtnAdd_Program.Enabled = true;
                ListBox_Program_Inc.Enabled = true;
                ListBox_Program_Exc.Enabled = true;

                foreach (ListItem l in chkProgramname.Items)
                {
                    l.Selected = false;
                }
            }
            else
            {
                ddl_Program_IncExc.Enabled = false;
                BtnAdd_Program.Enabled = false;
                ListBox_Program_Inc.Enabled = false;
                ListBox_Program_Exc.Enabled = false;

                LinkButton_Program_Inc.Visible = false;
                LinkButton_Program_Exc.Visible = false;
                ListBox_Program_Inc.Items.Clear();
                ListBox_Program_Exc.Items.Clear();

                foreach (ListItem l in chkProgramname.Items)
                {
                    l.Selected = true;
                }
            }
            
        }

        protected void LinkButton_Program_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Program_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProgramRemoveInc in ListBox_Program_Inc.Items)
                    {
                        if (lstProgramRemoveInc.Selected == true)
                            deleteditems.Add(lstProgramRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Program_Inc.Items.Remove(item);
                    }
                    if (ListBox_Program_Inc.Items.Count == 0)
                    {
                        LinkButton_Program_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_Program_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_Program_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstProgramRemoveExc in ListBox_Program_Exc.Items)
                    {
                        if (lstProgramRemoveExc.Selected == true)
                            deleteditems.Add(lstProgramRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_Program_Exc.Items.Remove(item);
                    }
                    if (ListBox_Program_Exc.Items.Count == 0)
                    {
                        LinkButton_Program_Exc.Visible = false;
                    }
                }
            }
        }

        protected void btnSearch_ruleid_Click(object sender, EventArgs e)
        {
            try
            {
                if (txt_ruleid.Text != "")
                {
                    if (CheckBoxList_RuleID.Items.Count > 0)
                        CheckBoxList_RuleID.Items.Clear();
                    bindRuleID(txt_ruleid.Text);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Visible = true;
                lblMessage.Text = "Error occured while searching for the Claim Edit RuleID. Please contact support team.";
                logger.Error("Error occured while searching for the Claim Edit RuleID :" + ex.Message);
            }
        }
        private void bindRuleID(string RuleID)
        {
            try
            {
                if (txt_ruleid.Text != "")
                {
                    DataTable dtRuleID = PerCentageClaimdbcon.getClaimEditRuleID(RuleID);
                    if (dtRuleID.Rows.Count > 0)
                    {
                        Pnl_RuleID.Visible = true;
                        CheckBoxList_RuleID.Visible = true;
                        CheckBoxList_RuleID.DataTextField = "ruleid";
                        CheckBoxList_RuleID.DataValueField = "ruleid";
                        CheckBoxList_RuleID.DataSource = dtRuleID;
                        CheckBoxList_RuleID.DataBind();
                    }

                }

            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message, ex);
            }
        }

        protected void CheckBox_All_Ruleid_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_All_Ruleid.Checked == false)
            {
                btnSearch_ruleid.Enabled = true;
                ddl_RuleID_IncExc.Enabled = true;
                BtnAdd_RuleID.Enabled = true;
                ListBox_RuleID_Inc.Enabled = true;
                ListBox_RuleID_Exc.Enabled = true;
            }
            else
            {
                btnSearch_ruleid.Enabled = false;
                ddl_RuleID_IncExc.Enabled = false;
                BtnAdd_RuleID.Enabled = false;
                ListBox_RuleID_Inc.Enabled = false;
                ListBox_RuleID_Exc.Enabled = false;
                Pnl_RuleID.Visible = false;
                LinkButton_RuleID_Inc.Visible = false;
                LinkButton_RuleID_Exc.Visible = false;
                ListBox_RuleID_Inc.Items.Clear();
                ListBox_RuleID_Exc.Items.Clear();
            }
        }

        protected void BtnAdd_RuleID_Click(object sender, EventArgs e)
        {
            try
            {
                foreach (ListItem lst in CheckBoxList_RuleID.Items)
                {
                    if (lst.Selected == true)
                    {
                        if (ddl_RuleID_IncExc.SelectedItem.Text == "Include")
                        {
                            if (ListBox_RuleID_Inc.Items.Count == 0)
                            {
                                if (ListBox_RuleID_Exc.Items.Count > 0)
                                { 
                                    if (ListBox_ServiceCode_Inc.Items.Contains(lst) == false && ListBox_RuleID_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_RuleID_Inc.DataTextField = lst.Text;
                                        ListBox_RuleID_Inc.DataValueField = lst.Value;
                                        ListBox_RuleID_Inc.Items.Add(lst);
                                        LinkButton_RuleID_Inc.Visible = true;
                                    }
                                }
                                else
                                {
                                    ListBox_RuleID_Inc.DataTextField = lst.Text;
                                    ListBox_RuleID_Inc.DataValueField = lst.Value;
                                    ListBox_RuleID_Inc.Items.Add(lst);
                                    LinkButton_RuleID_Inc.Visible = true;
                                }
                            }

                            else
                            {
                                if (ListBox_RuleID_Inc.Items.Contains(lst) == false && ListBox_RuleID_Exc.Items.Contains(lst) == false)
                                    {
                                        ListBox_RuleID_Inc.DataTextField = lst.Text;
                                        ListBox_RuleID_Inc.DataValueField = lst.Value;
                                        ListBox_RuleID_Inc.Items.Add(lst);
                                        LinkButton_RuleID_Inc.Visible = true;
                                    }
                            }
                        }
                        else if (ddl_RuleID_IncExc.SelectedItem.Text == "Exclude")
                        {
                            if (ListBox_RuleID_Exc.Items.Count == 0)
                            {
                                if (ListBox_RuleID_Exc.Items.Count > 0)
                                {
                                    if (ListBox_RuleID_Exc.Items.Contains(lst) == false && ListBox_RuleID_Inc.Items.Contains(lst) == false)
                                    {
                                        ListBox_RuleID_Exc.DataTextField = lst.Text;
                                        ListBox_RuleID_Exc.DataValueField = lst.Value;
                                        ListBox_RuleID_Exc.Items.Add(lst);
                                        //LinkButton_RuleID_Exc.Visible = true;
                                        LinkButton_RuleID_Exc.Visible = false;
                                    }
                                }
                                else
                                {
                                    ListBox_RuleID_Exc.DataTextField = lst.Text;
                                    ListBox_RuleID_Exc.DataValueField = lst.Value;
                                    ListBox_RuleID_Exc.Items.Add(lst);
                                    //LinkButton_RuleID_Exc.Visible = true;
                                    LinkButton_RuleID_Exc.Visible = false;
                                }
                            }
                            else
                            {
                                if (ListBox_RuleID_Inc.Items.Contains(lst) == false && ListBox_RuleID_Exc.Items.Contains(lst) == false)
                                {
                                    ListBox_RuleID_Exc.DataTextField = lst.Text;
                                    ListBox_RuleID_Exc.DataValueField = lst.Value;
                                    ListBox_RuleID_Exc.Items.Add(lst);
                                    //LinkButton_RuleID_Exc.Visible = true;
                                    LinkButton_RuleID_Exc.Visible = false;
                                }
                            }
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error occured while adding ClaimEdit RuleID. Please contact support team.";
                logger.Error("Error occured while adding ClaimEdit RuleID : " + ex.Message);
            }
        }

        protected void CheckBox_ClaimOver_Dollar_CheckedChanged(object sender, EventArgs e)
        {
            if (CheckBox_ClaimOver_Dollar.Checked == false)
            {
                txt_dollar_claim.Visible = true;
            }
            else
            {
                txt_dollar_claim.Visible = false;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearPerCentageClaimSelection();
        }
        //Code Added on 04/02/2024(IDEA0060156) Start
        protected void ddl_postpay_prepay_claim_SelectedIndexChanged(object sender, EventArgs e)
        {
            String Interfaceid = "";//Code Added on 08/07/2024 For Email Notification Change
            if (ddl_postpay_prepay_claim.SelectedItem.Text == "PostPay Claim")
            {
                loadAuditType("PostPay Claim");
                div_postpay_claim.Visible = true;
                div_prepay_claim.Visible = false;
                Interfaceid = "INT00000608";//Code Added on 08/07/2024 For Email Notification Change(Start)
            }
            else if (ddl_postpay_prepay_claim.SelectedItem.Text == "PrePay Claim")
            {
                loadAuditType("PrePay Claim");
                div_postpay_claim.Visible = false;
                div_prepay_claim.Visible = true;
                Interfaceid = "INT00000619";//Code Added on 08/07/2024 For Email Notification Change(Start)
            }

            Page_Load(sender, e);
                
        }
        //Code Added on 04/02/2024(IDEA0060156) End

        protected void LinkButton_RuleID_Inc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_RuleID_Inc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstRuleIDRemoveInc in ListBox_RuleID_Inc.Items)
                    {
                        if (lstRuleIDRemoveInc.Selected == true)
                            deleteditems.Add(lstRuleIDRemoveInc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_RuleID_Inc.Items.Remove(item);
                    }
                    if (ListBox_RuleID_Inc.Items.Count == 0)
                    {
                        LinkButton_RuleID_Inc.Visible = false;
                    }
                }
            }
        }

        protected void LinkButton_RuleID_Exc_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                if (ListBox_RuleID_Exc.Items.Count > 0)
                {
                    List<ListItem> deleteditems = new List<ListItem>();
                    foreach (ListItem lstRuleIDRemoveExc in ListBox_RuleID_Exc.Items)
                    {
                        if (lstRuleIDRemoveExc.Selected == true)
                            deleteditems.Add(lstRuleIDRemoveExc);
                    }
                    foreach (ListItem item in deleteditems)
                    {
                        ListBox_RuleID_Exc.Items.Remove(item);
                    }
                    if (ListBox_RuleID_Exc.Items.Count == 0)
                    {
                        LinkButton_RuleID_Exc.Visible = false;
                    }
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                
                ExtractType = ddl_ExtractType.SelectedItem.Value.ToString();

            //progids_Included,Progids_Excluded
                //CheckBox_All_Programs
                //ddl_Program_IncExc
                //ListBox_Program_Inc
                //ListBox_Program_Exc


                if (CheckBox_All_Programs.Checked == true)
                {
                    
                    progids_Included = "ALL";
                    Progids_Excluded = "NONE";
                }
                else
                {
                    if(ListBox_Program_Inc.Items.Count>0)
                    {
                        List<ListItem> IncludedProgramids = new List<ListItem>();
                        foreach (ListItem lstProgramidIncluded in ListBox_Program_Inc.Items)
                        {

                            IncludedProgramids.Add(lstProgramidIncluded);
                            progids_Included = string.Join(";", IncludedProgramids).Replace(" ", "");

                        }
                        //progids_Included = progids_Included + ";";//Commented on 05/02/2024
                    }
                    else if(ListBox_Program_Inc.Items.Count == 0)
                    {
                        progids_Included = "";
                    }
                    if(ListBox_Program_Exc.Items.Count > 0)
                    {
                        List<ListItem> ExcludedProgramids = new List<ListItem>();
                        foreach (ListItem lstProgramidExcluded in ListBox_Program_Exc.Items)
                        {

                            ExcludedProgramids.Add(lstProgramidExcluded);
                            Progids_Excluded = string.Join(";", ExcludedProgramids).Replace(" ", "");

                        }
                        //Progids_Excluded = Progids_Excluded + ";";//Commented on 05/02/2024
                    }
                    else if(ListBox_Program_Exc.Items.Count == 0)
                    {

                        Progids_Excluded = "";
                    }
                    

                }

                //Adjudicators_Included, Adjudicators_Excluded
                    //CheckBox_All_Adjudicators
                    //ListBox_Adjudicators_Inc
                    //ListBox_Adjudicators_Exc
                    
                if (CheckBox_All_Adjudicators.Checked == true)
                {

                    Adjudicators_Included = "ALL";
                    Adjudicators_Excluded = "NONE";
                }
                else
                {
                    if (ListBox_Adjudicators_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedAdjudicators = new List<ListItem>();
                        foreach (ListItem lstAdjudicatorsIncluded in ListBox_Adjudicators_Inc.Items)
                        {

                            IncludedAdjudicators.Add(lstAdjudicatorsIncluded);
                            Adjudicators_Included = string.Join(";", IncludedAdjudicators).Replace(" ", "");

                        }
                        //Adjudicators_Included = Adjudicators_Included + ";"; //Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Adjudicators_Inc.Items.Count == 0)
                    {
                        Adjudicators_Included = "";
                    }
                    if (ListBox_Adjudicators_Exc.Items.Count > 0)
                    {
                        List<ListItem> ExcludedAdjudicators = new List<ListItem>();
                        foreach (ListItem lstAdjudicatorsExcluded in ListBox_Adjudicators_Exc.Items)
                        {

                            ExcludedAdjudicators.Add(lstAdjudicatorsExcluded);
                            Adjudicators_Excluded = string.Join(";", ExcludedAdjudicators).Replace(" ", "");//Code Changed on 05 / 02 / 2024

                        }
                        //Adjudicators_Excluded = Adjudicators_Excluded + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Adjudicators_Exc.Items.Count == 0)
                    {

                        Adjudicators_Excluded = "";
                    }


                }

                

            //Providers_Included
                //chkAllProviders
                //ListBox_Providers_Inc
                

                if (chkAllProviders.Checked == true)
                {

                    Providers_Included = "ALL";
                    
                }
                else
                {
                    if (ListBox_Providers_Inc.Items.Count > 0)
                    {
                        var selected = ListBox_Providers_Inc.GetSelectedIndices().ToList();
                        List<string> selectedValues = new List<string>();
                         selectedValues = (from c in selected
                                              select ListBox_Providers_Inc.Items[c].Value).ToList();
                        List<string> IncludedProviderCodes = new List<string>();
                        foreach (string lstProviderCodesIncluded in selectedValues)
                        {

                            IncludedProviderCodes.Add(lstProviderCodesIncluded);
                            Providers_Included = string.Join(";", selectedValues).Replace(" ", "");

                        }
                        //Providers_Included = Providers_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Providers_Inc.Items.Count == 0)
                    {
                        Providers_Included = "";
                    }
                 }
            //dxcodes_Included
                //CheckBox_dxCode
                //ListBox_dxCode_Inc

                if (CheckBox_dxCode.Checked == true)
                {

                    dxcodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_dxCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludeddxCodes = new List<ListItem>();
                        foreach (ListItem lstdxcodesIncluded in ListBox_dxCode_Inc.Items)
                        {

                            IncludeddxCodes.Add(lstdxcodesIncluded);
                            dxcodes_Included = string.Join(";", IncludeddxCodes).Replace(" ", "");

                        }
                        //dxcodes_Included = dxcodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_dxCode_Inc.Items.Count == 0)
                    {
                        dxcodes_Included = "";
                    }
                }

            //procodes_Included
                //chkAllProcCode
                //ListBox_ProcCode_Inc

                if (chkAllProcCode.Checked == true)
                {

                    procodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_ProcCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedProcCodes = new List<ListItem>();
                        foreach (ListItem lstProcCodesIncluded in ListBox_ProcCode_Inc.Items)
                        {

                            IncludedProcCodes.Add(lstProcCodesIncluded);
                            procodes_Included = string.Join(";", IncludedProcCodes).Replace(" ", "");

                        }
                        //procodes_Included = procodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        procodes_Included = "";
                    }
                }

            //Poscodes_Included
                //CheckBox_ServiceCode
                //ListBox_ServiceCode_Inc

                if (CheckBox_ServiceCode.Checked == true)
                {

                    Poscodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_ServiceCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedPosCodes = new List<ListItem>();
                        foreach (ListItem lstPosCodesIncluded in ListBox_ServiceCode_Inc.Items)
                        {

                            IncludedPosCodes.Add(lstPosCodesIncluded);
                            Poscodes_Included = string.Join(";", IncludedPosCodes).Replace(" ", "");

                        }
                        //Poscodes_Included = Poscodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        Poscodes_Included = "";
                    }
                }

            //RuleIDs_Included
                //CheckBox_All_Ruleid
                //ListBox_RuleID_Inc

                if (CheckBox_All_Ruleid.Checked == true)
                {

                    RuleIDs_Included = "ALL";

                }
                else
                {
                    if (ListBox_RuleID_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedRuleIDs = new List<ListItem>();
                        foreach (ListItem lstRuleIDsIncluded in ListBox_RuleID_Inc.Items)
                        {

                            IncludedRuleIDs.Add(lstRuleIDsIncluded);
                            RuleIDs_Included = string.Join(";", IncludedRuleIDs).Replace(" ", "");

                        }
                        //RuleIDs_Included = RuleIDs_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        RuleIDs_Included = "";
                    }
                }
                
                if(CheckBox_ClaimOver_Dollar.Checked == true)
                {
                    Claim_Over_Dollar = "ALL";
                }
                else
                {
                    Claim_Over_Dollar = txt_dollar_claim.Text.ToString();
                }
                
                Number_Percent_Claim = txt_percent_claim.Text.ToString();

                if (IsPostBack)
                {
                    dt_begin.SelectedDate =
                        DateTime.ParseExact(txt_begin_date.Text, dt_begin.Format, null);
                    
                    dt_end.SelectedDate =
                        DateTime.ParseExact(txt_End_date.Text, dt_end.Format, null);
                    
                }

                begin_date = Convert.ToDateTime(txt_begin_date.Text);
                    end_date = Convert.ToDateTime(txt_End_date.Text);
                if (ExtractType != "")//Code Added on 05/23/2024 C32-7448
                {
                    if (Number_Percent_Claim.ToString() != "")
                {


                    if (begin_date.ToString() != "")
                    {
                        if (end_date.ToString() != "")
                        {

                            if (begin_date <= end_date)
                            {



                                if (txt_percent_claim.Text.Contains("%") || !txt_percent_claim.Text.Contains("."))
                                {
                                    //PerCentageClaimdbcon.Update_Percentage_Claim_Audit_Adhoc(ExtractType, progids_Included, Progids_Excluded, Adjudicators_Included, Adjudicators_Excluded, begin_date, end_date, Providers_Included, dxcodes_Included, procodes_Included, Poscodes_Included, RuleIDs_Included, Claim_Over_Dollar, Number_Percent_Claim);
                                    PerCentageClaimdbcon.Update_Percentage_Claim_Audit_Adhoc(ddl_postpay_prepay_claim.SelectedItem.Text.ToString(),ExtractType, progids_Included, Progids_Excluded, Adjudicators_Included, Adjudicators_Excluded, begin_date, end_date, Providers_Included, dxcodes_Included, procodes_Included, Poscodes_Included, RuleIDs_Included, Claim_Over_Dollar, Number_Percent_Claim); //Code Added on 04 / 02 / 2024(IDEA0060156)
                                    clearPerCentageClaimSelection();
                                    lblMessage.Visible = true;
                                    lblMessage.Text = "Percentage Claim Audit Adhoc details Updated successfully";
                                     
                                        logger.Info("Percentage Claim Audit Adhoc details Updated successfully");
                                    Page.SetFocus(lblMessage);
                                        //Code Added on 08/07/2024 For Email Notification Change(Start)
                                        //main_Panel.Enabled = false;
                                        Page_Load(sender, e);
                                        
                                        //Code Added on 08/07/2024 For Email Notification Change(End)
                                    }
                                    else
                                {
                                    lblMessage.Visible = true;
                                    lblMessage.Text = "Number or Percentage Claim Should not be Decimal Number";
                                    txt_dollar_claim.Text = "";
                                }




                            }
                            else
                            {
                                lblMessage.Visible = true;
                                lblMessage.Text = "Ending Date should be greater than Beginning Date";
                                txt_begin_date.Text = "";
                                txt_End_date.Text = "";
                            }
                        }
                        else
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "End Date Must be Mandatory";
                            txt_End_date.Focus();
                        }
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Begin Date Must be Mandatory";
                        txt_begin_date.Focus();
                    }
                }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Number or Percent Vale Must be Mandatory";
                        txt_percent_claim.Focus();
                    }
                }
                else//Code Added on 05/23/2024 C32-7448
                {
                    clearPerCentageClaimSelection();
                    lblMessage.Visible = true;
                    lblMessage.Text = "Extract Type Should not be Blank Value";//Code Added on 05/23/2024 C32-7448




                }

            }
            catch (Exception ex)
            {
                if (dt_begin.SelectedDate is null)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please Select Begin Date";
                    txt_begin_date.Focus();
                }
                else if (dt_end.SelectedDate is null)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please Select End Date";
                    txt_End_date.Focus();
                }
                else
                {


                    lblMessage.Text = "Error occured while Submitting Percentage Claim Audit Adhoc detail. Please contact support team.";
                    lblMessage.Visible = true;
                    logger.Error("Error occured while Submitting Percentage Claim Audit Adhoc detail : " + ex.Message);
                }
            }
        }
        //Code Added on 08/07/2024 For Email Notification Change(Start)
        protected void btnCheck_Click(object sender, EventArgs e)
        {
            try
            {

                ExtractType = ddl_ExtractType.SelectedItem.Value.ToString();

                //progids_Included,Progids_Excluded
                //CheckBox_All_Programs
                //ddl_Program_IncExc
                //ListBox_Program_Inc
                //ListBox_Program_Exc


                if (CheckBox_All_Programs.Checked == true)
                {

                    progids_Included = "ALL";
                    Progids_Excluded = "NONE";
                }
                else
                {
                    if (ListBox_Program_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedProgramids = new List<ListItem>();
                        foreach (ListItem lstProgramidIncluded in ListBox_Program_Inc.Items)
                        {

                            IncludedProgramids.Add(lstProgramidIncluded);
                            progids_Included = string.Join(";", IncludedProgramids).Replace(" ", "");

                        }
                        //progids_Included = progids_Included + ";";//Commented on 05/02/2024
                    }
                    else if (ListBox_Program_Inc.Items.Count == 0)
                    {
                        progids_Included = "";
                    }
                    if (ListBox_Program_Exc.Items.Count > 0)
                    {
                        List<ListItem> ExcludedProgramids = new List<ListItem>();
                        foreach (ListItem lstProgramidExcluded in ListBox_Program_Exc.Items)
                        {

                            ExcludedProgramids.Add(lstProgramidExcluded);
                            Progids_Excluded = string.Join(";", ExcludedProgramids).Replace(" ", "");

                        }
                        //Progids_Excluded = Progids_Excluded + ";";//Commented on 05/02/2024
                    }
                    else if (ListBox_Program_Exc.Items.Count == 0)
                    {

                        Progids_Excluded = "";
                    }


                }

                //Adjudicators_Included, Adjudicators_Excluded
                //CheckBox_All_Adjudicators
                //ListBox_Adjudicators_Inc
                //ListBox_Adjudicators_Exc

                if (CheckBox_All_Adjudicators.Checked == true)
                {

                    Adjudicators_Included = "ALL";
                    Adjudicators_Excluded = "NONE";
                }
                else
                {
                    if (ListBox_Adjudicators_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedAdjudicators = new List<ListItem>();
                        foreach (ListItem lstAdjudicatorsIncluded in ListBox_Adjudicators_Inc.Items)
                        {

                            IncludedAdjudicators.Add(lstAdjudicatorsIncluded);
                            Adjudicators_Included = string.Join(";", IncludedAdjudicators).Replace(" ", "");

                        }
                        //Adjudicators_Included = Adjudicators_Included + ";"; //Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Adjudicators_Inc.Items.Count == 0)
                    {
                        Adjudicators_Included = "";
                    }
                    if (ListBox_Adjudicators_Exc.Items.Count > 0)
                    {
                        List<ListItem> ExcludedAdjudicators = new List<ListItem>();
                        foreach (ListItem lstAdjudicatorsExcluded in ListBox_Adjudicators_Exc.Items)
                        {

                            ExcludedAdjudicators.Add(lstAdjudicatorsExcluded);
                            Adjudicators_Excluded = string.Join(";", ExcludedAdjudicators).Replace(" ", "");//Code Changed on 05 / 02 / 2024

                        }
                        //Adjudicators_Excluded = Adjudicators_Excluded + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Adjudicators_Exc.Items.Count == 0)
                    {

                        Adjudicators_Excluded = "";
                    }


                }



                //Providers_Included
                //chkAllProviders
                //ListBox_Providers_Inc


                if (chkAllProviders.Checked == true)
                {

                    Providers_Included = "ALL";

                }
                else
                {
                    if (ListBox_Providers_Inc.Items.Count > 0)
                    {
                        var selected = ListBox_Providers_Inc.GetSelectedIndices().ToList();
                        List<string> selectedValues = new List<string>();
                        selectedValues = (from c in selected
                                          select ListBox_Providers_Inc.Items[c].Value).ToList();
                        List<string> IncludedProviderCodes = new List<string>();
                        foreach (string lstProviderCodesIncluded in selectedValues)
                        {

                            IncludedProviderCodes.Add(lstProviderCodesIncluded);
                            Providers_Included = string.Join(";", selectedValues).Replace(" ", "");

                        }
                        //Providers_Included = Providers_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_Providers_Inc.Items.Count == 0)
                    {
                        Providers_Included = "";
                    }
                }
                //dxcodes_Included
                //CheckBox_dxCode
                //ListBox_dxCode_Inc

                if (CheckBox_dxCode.Checked == true)
                {

                    dxcodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_dxCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludeddxCodes = new List<ListItem>();
                        foreach (ListItem lstdxcodesIncluded in ListBox_dxCode_Inc.Items)
                        {

                            IncludeddxCodes.Add(lstdxcodesIncluded);
                            dxcodes_Included = string.Join(";", IncludeddxCodes).Replace(" ", "");

                        }
                        //dxcodes_Included = dxcodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_dxCode_Inc.Items.Count == 0)
                    {
                        dxcodes_Included = "";
                    }
                }

                //procodes_Included
                //chkAllProcCode
                //ListBox_ProcCode_Inc

                if (chkAllProcCode.Checked == true)
                {

                    procodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_ProcCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedProcCodes = new List<ListItem>();
                        foreach (ListItem lstProcCodesIncluded in ListBox_ProcCode_Inc.Items)
                        {

                            IncludedProcCodes.Add(lstProcCodesIncluded);
                            procodes_Included = string.Join(";", IncludedProcCodes).Replace(" ", "");

                        }
                        //procodes_Included = procodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        procodes_Included = "";
                    }
                }

                //Poscodes_Included
                //CheckBox_ServiceCode
                //ListBox_ServiceCode_Inc

                if (CheckBox_ServiceCode.Checked == true)
                {

                    Poscodes_Included = "ALL";

                }
                else
                {
                    if (ListBox_ServiceCode_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedPosCodes = new List<ListItem>();
                        foreach (ListItem lstPosCodesIncluded in ListBox_ServiceCode_Inc.Items)
                        {

                            IncludedPosCodes.Add(lstPosCodesIncluded);
                            Poscodes_Included = string.Join(";", IncludedPosCodes).Replace(" ", "");

                        }
                        //Poscodes_Included = Poscodes_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        Poscodes_Included = "";
                    }
                }

                //RuleIDs_Included
                //CheckBox_All_Ruleid
                //ListBox_RuleID_Inc

                if (CheckBox_All_Ruleid.Checked == true)
                {

                    RuleIDs_Included = "ALL";

                }
                else
                {
                    if (ListBox_RuleID_Inc.Items.Count > 0)
                    {
                        List<ListItem> IncludedRuleIDs = new List<ListItem>();
                        foreach (ListItem lstRuleIDsIncluded in ListBox_RuleID_Inc.Items)
                        {

                            IncludedRuleIDs.Add(lstRuleIDsIncluded);
                            RuleIDs_Included = string.Join(";", IncludedRuleIDs).Replace(" ", "");

                        }
                        //RuleIDs_Included = RuleIDs_Included + ";";//Commented on 05 / 02 / 2024
                    }
                    else if (ListBox_ProcCode_Inc.Items.Count == 0)
                    {
                        RuleIDs_Included = "";
                    }
                }

                if (CheckBox_ClaimOver_Dollar.Checked == true)
                {
                    Claim_Over_Dollar = "ALL";
                }
                else
                {
                    Claim_Over_Dollar = txt_dollar_claim.Text.ToString();
                }

                Number_Percent_Claim = txt_percent_claim.Text.ToString();

                if (IsPostBack)
                {
                    dt_begin.SelectedDate =
                        DateTime.ParseExact(txt_begin_date.Text, dt_begin.Format, null);

                    dt_end.SelectedDate =
                        DateTime.ParseExact(txt_End_date.Text, dt_end.Format, null);

                }

                begin_date = Convert.ToDateTime(txt_begin_date.Text);
                end_date = Convert.ToDateTime(txt_End_date.Text);
                if (ExtractType != "")//Code Added on 05/23/2024 C32-7448
                {
                    if (Number_Percent_Claim.ToString() != "")
                    {


                        if (begin_date.ToString() != "")
                        {
                            if (end_date.ToString() != "")
                            {

                                if (begin_date <= end_date)
                                {



                                    if (txt_percent_claim.Text.Contains("%") || !txt_percent_claim.Text.Contains("."))
                                    {
                                        //PerCentageClaimdbcon.Update_Percentage_Claim_Audit_Adhoc(ExtractType, progids_Included, Progids_Excluded, Adjudicators_Included, Adjudicators_Excluded, begin_date, end_date, Providers_Included, dxcodes_Included, procodes_Included, Poscodes_Included, RuleIDs_Included, Claim_Over_Dollar, Number_Percent_Claim);
                                        PerCentageClaimdbcon.Update_Percentage_Claim_Audit_Adhoc(ddl_postpay_prepay_claim.SelectedItem.Text.ToString(), ExtractType, progids_Included, Progids_Excluded, Adjudicators_Included, Adjudicators_Excluded, begin_date, end_date, Providers_Included, dxcodes_Included, procodes_Included, Poscodes_Included, RuleIDs_Included, Claim_Over_Dollar, Number_Percent_Claim); //Code Added on 04 / 02 / 2024(IDEA0060156)
                                        clearPerCentageClaimSelection();
                                        lblMessage.Visible = true;
                                        lblMessage.Text = "Percentage Claim Audit Adhoc details Updated successfully";
                                        
                                        logger.Info("Percentage Claim Audit Adhoc details Updated successfully");
                                        Page.SetFocus(lblMessage);
                                        //Code Added on 08/07/2024 For Email Notification Change(Start)
                                        //main_Panel.Enabled = false;
                                        //btnCheck.Visible = false;
                                        // btnSubmit.Visible = false;
                                        //Session.Clear();
                                        //Session.Abandon();
                                        Page_Load(sender, e);
                                        //Code Added on 08/07/2024 For Email Notification Change(End)
                                    }
                                    else
                                    {
                                        lblMessage.Visible = true;
                                        lblMessage.Text = "Number or Percentage Claim Should not be Decimal Number";
                                        txt_dollar_claim.Text = "";
                                    }




                                }
                                else
                                {
                                    lblMessage.Visible = true;
                                    lblMessage.Text = "Ending Date should be greater than Beginning Date";
                                    txt_begin_date.Text = "";
                                    txt_End_date.Text = "";
                                }
                            }
                            else
                            {
                                lblMessage.Visible = true;
                                lblMessage.Text = "End Date Must be Mandatory";
                                txt_End_date.Focus();
                            }
                        }
                        else
                        {
                            lblMessage.Visible = true;
                            lblMessage.Text = "Begin Date Must be Mandatory";
                            txt_begin_date.Focus();
                        }
                    }
                    else
                    {
                        lblMessage.Visible = true;
                        lblMessage.Text = "Number or Percent Vale Must be Mandatory";
                        txt_percent_claim.Focus();
                    }
                }
                else//Code Added on 05/23/2024 C32-7448
                {
                    clearPerCentageClaimSelection();
                    lblMessage.Visible = true;
                    lblMessage.Text = "Extract Type Should not be Blank Value";//Code Added on 05/23/2024 C32-7448




                }

            }
            catch (Exception ex)
            {
                if (dt_begin.SelectedDate is null)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please Select Begin Date";
                    txt_begin_date.Focus();
                }
                else if (dt_end.SelectedDate is null)
                {
                    lblMessage.Visible = true;
                    lblMessage.Text = "Please Select End Date";
                    txt_End_date.Focus();
                }
                else
                {


                    lblMessage.Text = "Error occured while Submitting Percentage Claim Audit Adhoc detail. Please contact support team.";
                    lblMessage.Visible = true;
                    logger.Error("Error occured while Submitting Percentage Claim Audit Adhoc detail : " + ex.Message);
                }
            }
        }
        //Code Added on 08/07/2024 For Email Notification Change(End)
    }
}
