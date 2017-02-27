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


            System.Data.DataTable caponInfo = DataBase.GetData("Transcapon", new string[] { "TransId" }, new string[] { Session["ParameterId"].ToString() });
            if (caponInfo.Rows.Count > 0)
            {
                CaponNo1.Text = caponInfo.Rows[0]["No"].ToString();
                CaponType1.Items.FindByValue(caponInfo.Rows[0]["Type"].ToString()).Selected = true;

                if (caponInfo.Rows.Count > 1)
                {
                    CaponNo2.Text = caponInfo.Rows[1]["No"].ToString();
                    CaponType2.Items.FindByValue(caponInfo.Rows[1]["Type"].ToString()).Selected = true;

                }
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



                if (DataBase.UpdateData("Transports", new string[] { DataBase.ArrivalTime1, DataBase.Tonnage2, DataBase.EmptyingNo, DataBase.UpdateUserId1, DataBase.UpdateTime1,"DocNo" }, new string[] { x.ToString(), TextBox3.Text, TextBox4.Text, Session["id"].ToString(), DateTime.Now.ToString(),DocNo.Text }, "id", Session["ParameterId"].ToString()))
                {

                    DataBase.Delete("transcapon", "transid", Session["ParameterId"].ToString());    
                    if (CaponNo1.Text.Length != 0)
                    {

                        DataBase.Insert("TransCapon", new string[] { "Transid", "No", "Type" }, new string[] { Session["ParameterId"].ToString(), CaponNo1.Text, CaponType1.SelectedValue });
                        

                    }

                    if (CaponNo2.Text.Length != 0)
                    {

                        DataBase.Insert("TransCapon", new string[] { "Transid", "No", "Type" }, new string[] { Session["ParameterId"].ToString(), CaponNo2.Text, CaponType2.SelectedValue });
                        

                    }
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

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int tmp;
        if (int.TryParse(DocNo.Text, out tmp))
        {
            System.Data.DataTable dt = DataBase.GetData("Transports", new string[] {"DocNo" }, new string[] {DocNo.Text });
            if (dt.Rows.Count == 0)
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = false;
        }
    }


    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (CaponNo1.Text.Length != 0)
        {
            int tmp;
            if (int.TryParse(CaponNo1.Text, out tmp))
            {
                System.Data.DataTable dt = DataBase.EXESQL("select * from Transcapon where type=" + CaponType1.SelectedValue + " and no=" + CaponNo1.Text + " and not transid=" + Session["ParameterId"].ToString());
                if (dt.Rows.Count == 0)
                {
                    if (CaponNo1.Text.Equals(CaponNo2.Text) && CaponType1.SelectedValue.Equals(CaponType2.SelectedValue))
                    {
                        args.IsValid = false;
                    }
                    else
                    {
                        args.IsValid = true;
                    }

                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = true;
        }
    }

    protected void CustomValidator4_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (CaponNo2.Text.Length != 0)
        {
            int tmp;
            if (int.TryParse(CaponNo2.Text, out tmp))
            {
                System.Data.DataTable dt = DataBase.EXESQL("select * from Transcapon where type=" + CaponType2.SelectedValue + " and no=" + CaponNo2.Text + " and not transid=" + Session["ParameterId"].ToString());
                if (dt.Rows.Count == 0)
                {
                    if (CaponNo1.Text.Equals(CaponNo2.Text) && CaponType1.SelectedValue.Equals(CaponType2.SelectedValue))
                    {
                        args.IsValid = false;
                    }
                    else
                    {
                        args.IsValid = true;
                    }
                }
                else
                {
                    args.IsValid = false;
                }
            }
            else
            {
                args.IsValid = false;
            }
        }
        else
        {
            args.IsValid = true;
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
        <tr class="tr2">
            <td>
                وزن التفريغ
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox3" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
               رقم التفريغ
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="TextBox4" runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr class="tr2">
            <td>
               رقم الوصل
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" Text="*" ControlToValidate="DocNo" ValidationGroup="g1" ErrorMessage="الرجاء ادخال رقم الوصل"></asp:RequiredFieldValidator>
                <asp:CustomValidator ID="CustomValidator1" runat="server" Text="*" ValidationGroup="g1" ControlToValidate="DocNo" ErrorMessage="الرجاء التأكد من رقم الوصل انه صحيح و غير مكرر" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox CssClass="Text" ID="DocNo" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات كابون الديزل
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            رقم الكابون الاول
                            <asp:CustomValidator ControlToValidate="CaponNo1" ID="CustomValidator3" runat="server" Text="*" ValidationGroup="g1" ErrorMessage="الرجاء التاكد من ان رقم الكابون الاول صحيح و غير مكرر" OnServerValidate="CustomValidator3_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="CaponNo1" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            فئة الكابون الاول
                        </td>
                        <td>
                            <asp:DropDownList ID="CaponType1" runat="server">
                                <asp:ListItem Text="50 لتر" Value="50"></asp:ListItem>
                                <asp:ListItem Text="330 لتر" Value="330"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    
                    <tr class="tr2">
                        <td >
                            رقم الكابون الثاني
                            <asp:CustomValidator ValidationGroup="g1" Text="*" ControlToValidate="CaponNo2" ID="CustomValidator4" runat="server" ErrorMessage="الرجاء التاكد من ان رقم الكابون الثاني صحيح و غير مكرر" OnServerValidate="CustomValidator4_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="CaponNo2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
			
                    <tr class="tr2">
                        <td >
                            فئة الكابون الثاني
                        </td>
                        <td>
                            <asp:DropDownList ID="CaponType2" runat="server">
                                <asp:ListItem Text="50 لتر" Value="50"></asp:ListItem>
                                <asp:ListItem Text="330 لتر" Value="330"></asp:ListItem>
                            </asp:DropDownList>
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

