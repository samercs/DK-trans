<%@ Page Title="ادخال حمولة جديدة" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Loads.aspx");
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

        Page.Validate("g1");
        

            
       if (Page.IsValid)
        {
            DateTime x = GetDate();
            DateTime x2=DateTime.Now;
            if (RadioButton1.Checked)
            {
                x2 = GetDate2();
            }
            Message msg; 
           
           if (RadioButton1.Checked)
            {
                if (DataBase.Insert(DataBase.Transports, new string[] { DataBase.DriverId, DataBase.CarID, DataBase.TrailerID, DataBase.Tonnage,DataBase.Tonnage2, DataBase.LoadNo, DataBase.EmptyingNo, DataBase.FromID, DataBase.ToID, DataBase.LeavingTime1,DataBase.ArrivalTime1, DataBase.EnterUserId1, DataBase.UpdateUserId1, DataBase.EnterTime1, DataBase.UpdateTime1 }, new string[] { DropDownList1.SelectedValue, DropDownList2.SelectedValue, DropDownList3.SelectedValue, TextBox1.Text,TextBox8.Text, TextBox4.Text, TextBox5.Text, DropDownList4.SelectedValue, DropDownList5.SelectedValue, x.ToString(),x2.ToString(), Session["Id"].ToString(), Session["Id"].ToString(), DateTime.Now.ToString(), DateTime.Now.ToString() }))
                {
                    msg = new Message("تم اضافة الحمولة", true, "Loads.aspx", "Loads.aspx");
                }
                else
                {

                    msg = new Message("لم يتم اضافة الحمولة الرجاء اعادة المحاولة", false, "Loads.aspx", "Loads.aspx");
                }
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            else
            {
                if (DataBase.Insert(DataBase.Transports, new string[] { DataBase.DriverId, DataBase.CarID, DataBase.TrailerID, DataBase.Tonnage,DataBase.Tonnage2, DataBase.LoadNo, DataBase.EmptyingNo, DataBase.FromID, DataBase.ToID, DataBase.LeavingTime1, DataBase.EnterUserId1, DataBase.EnterTime1 }, new string[] { DropDownList1.SelectedValue, DropDownList2.SelectedValue, DropDownList3.SelectedValue, TextBox1.Text,TextBox8.Text, TextBox4.Text, TextBox5.Text, DropDownList4.SelectedValue, DropDownList5.SelectedValue, x.ToString(), Session["Id"].ToString(), DateTime.Now.ToString() }))
                {
                    msg = new Message("تم اضافة الحمولة", true, "Loads.aspx", "Loads.aspx");
                }
                else
                {

                    msg = new Message("لم يتم اضافة الحمولة الرجاء اعادة المحاولة", false, "Loads.aspx", "Loads.aspx");
                }
                Session["MSG"] = msg;
                Response.Redirect("Message.aspx");
            }
            
            

            
            
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            int CurentYear = DateTime.Now.Year;
            for (int i = 1; i <= 31; i++)
            {
                if (i <= 12)
                {
                    month.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    month2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                day.Items.Add(new ListItem(i.ToString(), i.ToString()));
                day2.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year.Items.Add(new ListItem(i.ToString(), i.ToString()));
                year2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            if (day.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (day2.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day2.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (month2.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }

            if (year.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }

            if (year2.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year2.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
        }
        
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try
        {
            if (RadioButton1.Checked)
            {
                GetDate();
                GetDate2();
            }
            else
            {
                GetDate();
            }
            args.IsValid = true;
        }
        catch
        {
            args.IsValid = false;
        }
        
    }

    private DateTime GetDate()
    {
        DateTime Time = DateTime.Now;
        DateTime x = DateTime.Now; 
        Time = DateTime.Parse(TextBox2.Text + ":" + TextBox3.Text + ":00");
        x = new DateTime(int.Parse(year.SelectedValue), int.Parse(month.SelectedValue), int.Parse(day.SelectedValue), Time.Hour, Time.Minute, Time.Second);
        return x;
    }

    private DateTime GetDate2()
    {
        DateTime Time = DateTime.Now;
        DateTime x = DateTime.Now; 
        Time = DateTime.Parse(TextBox7.Text + ":" + TextBox6.Text + ":00" );
        x = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue), Time.Hour, Time.Minute, Time.Second);
        return x;
    }

    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        System.Data.DataTable dt = DataBase.GetData("Transports", new string[] {"Loadno" }, new string[] {TextBox4.Text });
        if (dt.Rows.Count == 0)
        {
            args.IsValid = true;
        }
        else
        {
            args.IsValid = false;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
   
    <table align="center" class="DataEnterTable">
        <tr>
            <td class="Title">
                ادخال حمولة جديدة
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات السائق
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            اسم السائق
                        </td>
                        <td>
                            <asp:DropDownList CssClass="Text" ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT     id, Name FROM Drivers Order By name"></asp:SqlDataSource>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات المركبة
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            رقم القاطرة
                        </td>
                        <td>
                            <asp:DropDownList CssClass="Text" ID="DropDownList2" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="Number" DataValueField="id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [id], [Number] FROM [Cars] order by number"></asp:SqlDataSource>
                            
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            رقم المقطورة
                        </td>
                        <td>
                            <asp:DropDownList CssClass="Text" ID="DropDownList3" runat="server" 
                                DataSourceID="SqlDataSource3" DataTextField="Number" DataValueField="id">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [id], [Number] FROM [Trailer] order by number"></asp:SqlDataSource>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات الحمولة
                            
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            الحمولة/طن
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
                            <asp:RangeValidator ID="RangeValidator1" runat="server" 
                                ControlToValidate="TextBox1" ErrorMessage="الرجاء التاكد من كمية الحمولة" 
                                MaximumValue="70000" MinimumValue="0" SetFocusOnError="True" Type="Integer" 
                                ValidationGroup="g1">*</asp:RangeValidator>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="TextBox1" ErrorMessage="الرجاء ادخال الحمولة" 
                                ValidationGroup="g1">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                           وزن التفريغ  / طن
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox8" CssClass="Text" runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            رقم التحميل
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox4" CssClass="Text" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="TextBox4" ErrorMessage="الرجاء ادخال رقم التحميل" 
                                ValidationGroup="g1">*</asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ControlToValidate="TextBox4" Text="*" ErrorMessage=" هذة الحموله مدخله من قبل رقم التحميل مكرر" OnServerValidate="CustomValidator2_ServerValidate" ValidationGroup="g1"></asp:CustomValidator>
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            رقم التفريغ
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox5" CssClass="Text" runat="server"></asp:TextBox>
                            
                        </td>
                    </tr>
                    
                    
                   
                    
                    
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات المكان / وجهة الشحنة
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            مكان الانطلاق
                        </td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource4" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                
                                SelectCommand="SELECT [id], [Name] FROM [Centers]">
                                
                            </asp:SqlDataSource>
                            <asp:DropDownList ID="DropDownList4" runat="server" 
                                DataSourceID="SqlDataSource4" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="tr2">
                        <td >
                            مكان التفريغ
                        </td>
                        <td>
                           
                            <asp:DropDownList ID="DropDownList5" runat="server" 
                                DataSourceID="SqlDataSource4" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                            
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات الوقت
                        </td>
                    </tr>
                    <tr class="tr2">
                        
                        <td>
                            تاريخ التحميل
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="day" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="month" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="year" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <asp:CustomValidator ID="CustomValidator1" runat="server" Text="*" 
                                ControlToValidate="day" ValidationGroup="g1" 
                                ErrorMessage="الرجاء التاكد من تاريخ و وقت التفريغ" 
                                onservervalidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
                            
                        </td>
                        
                    </tr>
                    <tr class="tr2">
                        <td >
                            وقت الانطلاق
                        </td>
                        <td>
                            <table dir="rtl">
                                <tr align="center">
                                    
                                    
                                    <td>الدقائق</td>
                                    <td>الساعة</td>
                                    
                                </tr>
                                <tr>
                                    
                                    <td>
                                         <asp:RangeValidator ID="RangeValidator3" runat="server" 
                                ErrorMessage="الرجاء التاكد من الدقائق المدخلة" ControlToValidate="TextBox3" 
                                MaximumValue="59" MinimumValue="0" SetFocusOnError="True" Type="Integer" 
                                ValidationGroup="g1">*</asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                             ErrorMessage="الرجاء ادخال الدقائق" ControlToValidate="TextBox3" 
                                             ValidationGroup="g1">*</asp:RequiredFieldValidator>
                                        <asp:TextBox Width="30" ID="TextBox3" CssClass="Text" runat="server"></asp:TextBox> : 
                                        
                                    </td>
                                    <td><asp:TextBox Width="30" ID="TextBox2" CssClass="Text" runat="server"></asp:TextBox> 
                                    <asp:RangeValidator ID="RangeValidator2" runat="server" 
                                        ErrorMessage="الرجاء التاكد من الساعة المدخلة" ControlToValidate="TextBox2" 
                                        MaximumValue="23" MinimumValue="0" SetFocusOnError="True" Type="Integer" 
                                        ValidationGroup="g1" Display="Dynamic">*</asp:RangeValidator>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                            ErrorMessage="الرجاء التاكد من الساعة" ControlToValidate="TextBox2" 
                                            ValidationGroup="g1" Display="Dynamic">*</asp:RequiredFieldValidator>
                                    </td>
                                    
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr class="tr2">
                        <td>
                            <asp:RadioButton ID="RadioButton1" Text="وصلت" GroupName="g1" runat="server" /></td>
                        <td>
                            <asp:RadioButton ID="RadioButton2" Text="لم تصل" Checked="true" GroupName="g1" runat="server" /></td>
                        </td>
                    </tr>
                    
                    <tr class="tr2">
                        
                        <td>
                            تاريخ الوصول
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="day2" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="month2" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="year2" runat="server">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            
                        </td>
                        
                    </tr>
                    
                    <tr class="tr2">
                        <td >
                            وقت الوصول
                        </td>
                        <td>
                            <table dir="rtl">
                                <tr align="center">
                                    
                                    
                                    <td>الدقائق</td>
                                    <td>الساعة</td>
                                    
                                </tr>
                                <tr>
                                    <td>
                                        
                                    </td>
                                    <td>
                                         
                                        <asp:TextBox Width="30" ID="TextBox6" CssClass="Text" runat="server"></asp:TextBox> : 
                                        
                                    </td>
                                    <td><asp:TextBox Width="30" ID="TextBox7" CssClass="Text" runat="server"></asp:TextBox> 
                                    
                                    </td>
                                    
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    <tr>
                        <td class="tr2" colspan="2">
                            
                           
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td align="center" colspan="2">
                            <asp:ImageButton ID="ImageButton1"  ImageUrl="~/Images/Save.png" runat="server" 
                                onclick="ImageButton1_Click" ValidationGroup="g1" /> 
                            &nbsp;&nbsp;
                            <asp:ImageButton ID="ImageButton2"  ImageUrl="~/Images/Cancel.png" 
                                runat="server" onclick="ImageButton2_Click" /> 
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                DisplayMode="List" ShowMessageBox="True" ValidationGroup="g1" />
                            <br />
                        </td>
                    </tr>
                    
                </table>
            </td>
        </tr>
    </table>
</ContentTemplate>
</asp:UpdatePanel>
</asp:Content>

