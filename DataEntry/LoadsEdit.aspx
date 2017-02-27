<%@ Page Title="تعديل الحمولة" EnableViewState="true" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        if (Session["PID"] != null)
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
                        month3.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    }
                    day.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    day2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    day3.Items.Add(new ListItem(i.ToString(), i.ToString()));

                }
                for (int i = 2010; i <= CurentYear + 1; i++)
                {
                    year.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    year2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    year3.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }

                
                
                
                

                
            }
        }
        else
        {
            Response.Redirect("Loads.aspx");
        }
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        try
        {

            GetDate();
            GetDate2();
            GetDate3();

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
        
        if (DateTime.TryParse(TextBox7.Text + ":" + TextBox6.Text + ":00", out Time))
        {
            if (DateTime.TryParse(year2.SelectedValue+"-"+month2.SelectedValue+"-"+day2.SelectedValue+" "+Time.Hour+":"+Time.Minute+":"+Time.Second,out x))
            {
                return x;
            }
        }
        
        return x;
    }

    private DateTime GetDate3()
    {
        DateTime Time = DateTime.Now;
        DateTime x = DateTime.Now;

        if (DateTime.TryParse(TextBox10.Text + ":" + TextBox9.Text + ":00", out Time))
        {
            if (DateTime.TryParse(year3.SelectedValue + "-" + month3.SelectedValue + "-" + day3.SelectedValue + " " + Time.Hour + ":" + Time.Minute + ":" + Time.Second, out x))
            {
                return x;
            }
        }

        return x;
    }

    protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Loads.aspx");
    }

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {

        if (Session["PID2"].ToString().Equals("1"))
        {
            RequiredFieldValidator5.Enabled = false;
        }
        else
        {
            RequiredFieldValidator5.Enabled = true;
        }
        
        Page.Validate("g1");



        if (Page.IsValid)
        {
            DateTime x = GetDate();
            DateTime x2 = GetDate2();
            DateTime x3 = GetDate3();
            Message msg;

            if (Session["PID2"].ToString().Equals("1"))
            {
                if (DataBase.UpdateData(DataBase.Transports, new string[] { DataBase.DriverId, DataBase.CarID, DataBase.TrailerID, DataBase.Tonnage, DataBase.LoadNo,  DataBase.FromID, DataBase.ToID, DataBase.LeavingTime1 }, new string[] { DropDownList1.SelectedValue, DropDownList2.SelectedValue, DropDownList3.SelectedValue, TextBox1.Text, TextBox4.Text, DropDownList4.SelectedValue, DropDownList5.SelectedValue, x.ToString() },"id",Session["PID"].ToString()))
                {
                    DataBase.Delete("transcapon", "transid", Session["PID"].ToString());
                    if (CaponNo1.Text.Length != 0)
                    {
                        DataBase.Insert("TransCapon", new string[] {"TransId","No","type" }, new string[] {Session["PID"].ToString(),CaponNo1.Text,CaponType1.SelectedValue });
                    }
                    if (CaponNo2.Text.Length != 0)
                    {
                        DataBase.Insert("TransCapon", new string[] { "TransId", "No", "type" }, new string[] { Session["PID"].ToString(), CaponNo2.Text, CaponType2.SelectedValue });
                    }
                    msg = new Message("تم تعديل الحمولة", true, "Loads.aspx", "Loads.aspx");
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
                if (DataBase.UpdateData(DataBase.Transports, new string[] { DataBase.Tonnage2,DataBase.EmptyingNo,"ArrivalTime", DataBase.ArrivalTime1,"DocNo" }, new string[] { TextBox8.Text,TextBox5.Text,x3.ToString(),x2.ToString(),DocNo.Text},"id",Session["PID"].ToString()))
                {
                    DataBase.Delete("transcapon", "transid", Session["PID"].ToString());
                    if (CaponNo1.Text.Length != 0)
                    {
                        DataBase.Insert("TransCapon", new string[] { "TransId", "No", "type" }, new string[] { Session["PID"].ToString(), CaponNo1.Text, CaponType1.SelectedValue });
                    }
                    if (CaponNo2.Text.Length != 0)
                    {
                        DataBase.Insert("TransCapon", new string[] { "TransId", "No", "type" }, new string[] { Session["PID"].ToString(), CaponNo2.Text, CaponType2.SelectedValue });
                    }
                    msg = new Message("تم تعديل الحمولة", true, "Loads.aspx", "Loads.aspx");
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




    protected void Page_SaveStateComplete(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

            System.Data.DataTable caponInfo = DataBase.GetData("Transcapon", new string[] { "TransId"}, new string[] {Session["PID"].ToString() });
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
            System.Data.DataTable DT = DataBase.GetData("Transports", new string[] { "id" }, new string[] { Session["PID"].ToString() });
            if (DT.Rows.Count != 0)
            {
                DropDownList1.Items.FindByValue(DT.Rows[0]["DriverId"].ToString()).Selected = true;
                DropDownList2.Items.FindByValue(DT.Rows[0]["CarId"].ToString()).Selected = true;
                DropDownList3.Items.FindByValue(DT.Rows[0]["TrailerId"].ToString()).Selected = true;
                TextBox1.Text = DT.Rows[0]["Tonnage"].ToString();
                TextBox8.Text = DT.Rows[0]["Tonnage2"].ToString();
                TextBox4.Text = DT.Rows[0]["LoadNo"].ToString();
                TextBox5.Text = DT.Rows[0]["EmptyingNo"].ToString();
                DropDownList4.Items.FindByValue(DT.Rows[0]["FromID"].ToString()).Selected = true;
                DropDownList5.Items.FindByValue(DT.Rows[0]["ToID"].ToString()).Selected = true;
                DocNo.Text = DT.Rows[0]["DocNo"].ToString();
                DateTime tmp;
                if (DateTime.TryParse(DT.Rows[0]["LeavingTime1"].ToString(), out tmp))
                {
                    year.Items.FindByValue(tmp.Year.ToString()).Selected = true;
                    month.Items.FindByValue(tmp.Month.ToString()).Selected = true;
                    day.Items.FindByValue(tmp.Day.ToString()).Selected = true;
                    TextBox2.Text = tmp.Hour.ToString();
                    TextBox3.Text = tmp.Minute.ToString();
                }
                if (DateTime.TryParse(DT.Rows[0]["ArrivalTime1"].ToString(), out tmp))
                {
                    year2.Items.FindByValue(tmp.Year.ToString()).Selected = true;
                    month2.Items.FindByValue(tmp.Month.ToString()).Selected = true;
                    day2.Items.FindByValue(tmp.Day.ToString()).Selected = true;
                    TextBox7.Text = tmp.Hour.ToString();
                    TextBox6.Text = tmp.Minute.ToString();
                    
                }
                else
                {


                    if (day2.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
                    {
                        day2.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
                    }

                    if (month2.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
                    {
                        month2.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
                    }

                    if (year2.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
                    {
                        year2.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
                    }
                }



                if (DateTime.TryParse(DT.Rows[0]["ArrivalTime"].ToString(), out tmp))
                {
                    year3.Items.FindByValue(tmp.Year.ToString()).Selected = true;
                    month3.Items.FindByValue(tmp.Month.ToString()).Selected = true;
                    day3.Items.FindByValue(tmp.Day.ToString()).Selected = true;
                    TextBox10.Text = tmp.Hour.ToString();
                    TextBox9.Text = tmp.Minute.ToString();

                }
                else
                {


                    if (day3.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
                    {
                        day3.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
                    }

                    if (month3.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
                    {
                        month3.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
                    }

                    if (year3.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
                    {
                        year3.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
                    }
                }
                
                
                
                
            }


            DropDownList1.Enabled = false;
            DropDownList2.Enabled = false;
            DropDownList3.Enabled = false;
            DropDownList4.Enabled = false;
            DropDownList5.Enabled = false;
            year.Enabled = false;
            month.Enabled = false;
            day.Enabled = false;
            TextBox1.ReadOnly = true;
            TextBox4.ReadOnly = true;
            TextBox2.ReadOnly = true;
            TextBox3.ReadOnly = true;
            

            TextBox8.ReadOnly = true;
            TextBox5.ReadOnly = true;
            
            year2.Enabled = false;
            month2.Enabled = false;
            day2.Enabled = false;
            TextBox7.ReadOnly = true;
            TextBox8.ReadOnly = true;
            TextBox6.ReadOnly = true;

            TextBox9.ReadOnly = true;
            TextBox10.ReadOnly = true;
            
            if (Session["PID2"].ToString().Equals("1"))
            {
                DropDownList1.Enabled = true;
                DropDownList2.Enabled = true;
                DropDownList3.Enabled = true;
                DropDownList4.Enabled = true;
                DropDownList5.Enabled = true;
                year.Enabled = true;
                month.Enabled = true;
                day.Enabled = true;
                TextBox1.ReadOnly = false;
                TextBox4.ReadOnly = false;
                TextBox2.ReadOnly = false;
                TextBox3.ReadOnly = false;
                TextBox8.ReadOnly = true;
                TextBox5.ReadOnly = true;
                TextBox9.ReadOnly = false;
                TextBox10.ReadOnly = false;
                
                year2.Enabled = false;
                month2.Enabled = false;
                day2.Enabled = false;
                TextBox7.ReadOnly = true;
                TextBox6.ReadOnly = true;
                
            }
            else if (Session["PID2"].ToString().Equals("2"))
            {
                DropDownList1.Enabled = false;
                DropDownList2.Enabled = false;
                DropDownList3.Enabled = false;
                DropDownList4.Enabled = false;
                DropDownList5.Enabled = false;
                year.Enabled = false;
                month.Enabled = false;
                day.Enabled = false;
                TextBox1.ReadOnly = true;
                TextBox4.ReadOnly = true;
                TextBox2.ReadOnly = true;
                TextBox3.ReadOnly = true;
                

                TextBox8.ReadOnly = false;
                TextBox5.ReadOnly = false;
                
                year2.Enabled = true;
                month2.Enabled = true;
                day2.Enabled = true;
                TextBox7.ReadOnly = false;
                TextBox8.ReadOnly = false;
                TextBox6.ReadOnly = false;
                TextBox9.ReadOnly = true;
                TextBox10.ReadOnly = true;
                
            }
                
            
            
        }
    }

    protected void CustomValidator3_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (CaponNo1.Text.Length != 0)
        {
            int tmp;
            if (int.TryParse(CaponNo1.Text, out tmp))
            {
                System.Data.DataTable dt = DataBase.EXESQL("select * from TransCapon where (no=" + CaponNo1.Text + ") and (type=" + CaponType1.SelectedValue + ") and (not TransId=" + Session["PID"].ToString()+")");
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
                System.Data.DataTable dt = DataBase.EXESQL("select * from TransCapon where (no=" + CaponNo2.Text + ") and (type=" + CaponType2.SelectedValue + ") and (not TransId=" + Session["PID"].ToString() + ")");
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


    protected void CustomValidator2_ServerValidate(object source, ServerValidateEventArgs args)
    {
        int tmp;
        if (int.TryParse(DocNo.Text, out tmp))
        {
            System.Data.DataTable dt = DataBase.EXESQL("Select * from Transports where (DocNo=" + DocNo.Text + ") and (not id=" + Session["PID"].ToString() + ")");
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
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <table align="center" class="DataEnterTable">
        <tr>
            <td class="Title">
                تعديل معلومات الحمولة
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
                                SelectCommand="SELECT     id, Name FROM Drivers Order By Name"></asp:SqlDataSource>
                            
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
                                SelectCommand="SELECT [id], [Number] FROM [Cars] Order By Number"></asp:SqlDataSource>
                            
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
                                SelectCommand="SELECT [id], [Number] FROM [Trailer] Order By Number"></asp:SqlDataSource>
                            
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
                                MaximumValue="50000" MinimumValue="0" SetFocusOnError="True" Type="Integer" 
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
                                        
                                    </td>
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
                            تاريخ الوصول
                        </td>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        <asp:DropDownList ID="day3" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="month3" runat="server">
                                        </asp:DropDownList> - 
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="year3" runat="server">
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
                                         
                                        <asp:TextBox Width="30" ID="TextBox9" CssClass="Text" runat="server"></asp:TextBox> : 
                                        
                                    </td>
                                    <td><asp:TextBox Width="30" ID="TextBox10" CssClass="Text" runat="server"></asp:TextBox> 
                                    
                                    </td>
                                    
                                    
                                </tr>
                            </table>
                        </td>
                    </tr>
                    
                    
                    <tr class="tr2">
                        
                        <td>
                            تاريخ الانتهاء
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
                            وقت الانتهاء
                        </td>
                        <td>
                            <table dir="rtl">
                                <tr align="center">
                                    
                                    
                                    <td>الدقائق</td>
                                    <td>الساعة</td>
                                    
                                </tr>
                                <tr>
                                    
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
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات كابون الديزل
                        </td>
                    </tr>
                    <tr  class="tr2">
                        <td >
                            رقم الكابون الاول
                            <asp:CustomValidator ControlToValidate="CaponNo1" ID="CustomValidator3" runat="server" Text="*" ValidationGroup="g1" ErrorMessage="الرجاء التاكد من ان رقم الكابون الاول صحيح و غير مكرر" OnServerValidate="CustomValidator3_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="CaponNo1" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr  class="tr2">
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
                    
                    <tr  class="tr2">
                        <td >
                            رقم الكابون الثاني
                            <asp:CustomValidator ValidationGroup="g1" Text="*" ControlToValidate="CaponNo2" ID="CustomValidator4" runat="server" ErrorMessage="الرجاء التاكد من ان رقم الكابون الثاني صحيح و غير مكرر" OnServerValidate="CustomValidator4_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="CaponNo2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
			
                    <tr  class="tr2">
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


 <%if (Session["type"].ToString().Equals("3"))
   {%>
		            <tr>
                        <td colspan="2">
                            <hr />
                        </td>
                    </tr>
                    
                    <tr>
                        <td colspan="2" class="Title2">
                            معلومات الوصل
                        </td>
                    </tr>
                    <tr  class="tr2">
                        <td >
                            رقم الوصل
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="الرجاء ادخال رقم الوصل" Text="*" ControlToValidate="DocNo" ValidationGroup="g1"></asp:RequiredFieldValidator>
                            <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="الرجاء التأكد من رقم الوصل انه صحيح و غير مكرر" Text="*" ControlToValidate="DocNo" ValidationGroup="g1" OnServerValidate="CustomValidator2_ServerValidate"></asp:CustomValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="DocNo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
               <%} %>     
                    
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

</asp:Content>

