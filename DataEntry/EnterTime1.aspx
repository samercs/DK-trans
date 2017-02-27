<%@ Page Title="ادخال الوقت" Language="C#" MasterPageFile="~/DataEntry/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["type"] == null)
        {
            Response.Redirect("../Default.aspx");
        }
        else if (!Session["type"].Equals("3"))
        {
            Response.Redirect("Default.aspx");
        }
        
        if (Session["ParameterId"] == null)
        {
            Response.Redirect("CarArrival.aspx");
        }

        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    month.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                day.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (day.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }


            

        }
        
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Page.Validate("g1");
        if (Page.IsValid)
        {

            if (Session["ParameterId"] != null)
            {

                DateTime Time = DateTime.Parse(TextBox2.Text + ":" + TextBox1.Text + ":00");
                DateTime x = new DateTime(int.Parse(year.SelectedValue), int.Parse(month.SelectedValue), int.Parse(day.SelectedValue), Time.Hour, Time.Minute, Time.Second);



                if (DataBase.UpdateData("Transports", new string[] { "ArrivalTime" }, new string[] { x.ToString() }, "id", Session["ParameterId"].ToString()))
                {

                    
                    Message msg = new Message("تم حفظ معلومات التفريغ", true, "CarArrival.aspx", "CarArrival.aspx");
                    Session["MSG"] = msg;
                    Response.Redirect("Message.aspx");
                }
                else
                {
                    Message msg = new Message("لم يتم الحفظ يرجى المحاولة مرة اخرى", true, "CarArrival.aspx", "CarArrival.aspx");
                    Session["MSG"] = msg;
                    Response.Redirect("Message.aspx");
                }
            }
            else
            {
                Response.Redirect("CarArrival.aspx");
            }
        }
    }

    


    

    
    
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <table class="DataEnterTable" align="center">
        <tr align="center" class="Title">
            <td colspan="2" align="center">
                ادخال معلومات الوصول
            </td>
            
        </tr>
        <tr class="tr2">
            <td>
                تاريخ الوصول
            </td>
            <td>
                <asp:DropDownList ID="day" runat="server">
                </asp:DropDownList>                 
                -                 
                <asp:DropDownList ID="month" runat="server">
                </asp:DropDownList> -                 
                <asp:DropDownList ID="year" runat="server">
                </asp:DropDownList> 
            </td>
        </tr>
        
        <tr class="tr2">
            <td>
                وقت الوصول
            </td>
            <td>
                <table>
                    <tr align="center">
                        
                        <td>الدقائق</td>
                        <td>الساعة</td>
                        
                    </tr>
                    <tr>
                        
                        <td>
                            <asp:TextBox ID="TextBox1" CssClass="Text" Width="50" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ErrorMessage="الرجاء ادخال الدقائق" ControlToValidate="TextBox1" 
                                ValidationGroup="g1">*</asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                ErrorMessage="الرجاء التاكد من الدقائق" ControlToValidate="TextBox1" 
                                MaximumValue="59" MinimumValue="0" Type="Integer" ValidationGroup="g1">*</asp:RangeValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox2" CssClass="Text" Width="50" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ErrorMessage="الرجاء ادخال الساعة" ControlToValidate="TextBox2" 
                                ValidationGroup="g1">*</asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="RangeValidator2" runat="server" 
                                ErrorMessage="الرجاء التاكد من الساعة" ControlToValidate="TextBox2" 
                                MaximumValue="23" MinimumValue="0" Type="Integer" ValidationGroup="g1">*</asp:RangeValidator>
                        </td>
                    </tr>
                    
                    
                </table>
            </td>
        </tr>
        
        
        <tr>
            <td colspan="2" align="center">
                
                            <asp:ImageButton ID="ImageButton1" AlternateText="Save" ImageAlign="Middle" 
                                ImageUrl="~/Images/Save.png" runat="server" onclick="ImageButton1_Click" 
                                ValidationGroup="g1" /> 
                            <a href="CarArrival.aspx"><img border="0" align="middle" src="../Images/Cancel.png" /></a>
                            <br />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                DisplayMode="List" ShowMessageBox="True" ValidationGroup="g1" />
                       
            </td>
        </tr>
    </table>
    
</asp:Content>

