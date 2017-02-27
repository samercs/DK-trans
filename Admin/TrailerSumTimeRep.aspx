<%@ Page Title="تقرير حركات جميع المقطورات/في يوم و فترة وقت محددة" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        /*DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        SqlDataSource2.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource2.SelectParameters["d2"].DefaultValue = d2.ToString();
        //SqlDataSource2.SelectParameters["ToId"].DefaultValue = DropDownList1.SelectedValue.ToString();*/
        SqlDataSource2.DataBind();
        GridView1.DataBind();
        
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
                    month1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                    month2.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
                day1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                day2.Items.Add(new ListItem(i.ToString(), i.ToString()));

            }
            for (int i = 2010; i <= CurentYear + 1; i++)
            {
                year1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                year2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

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

            if (year1.Items.FindByValue(DateTime.Now.Year.ToString()) != null)
            {
                year1.Items.FindByValue(DateTime.Now.Year.ToString()).Selected = true;
            }
            if (day1.Items.FindByValue(DateTime.Now.Day.ToString()) != null)
            {
                day1.Items.FindByValue(DateTime.Now.Day.ToString()).Selected = true;
            }

            if (month1.Items.FindByValue(DateTime.Now.Month.ToString()) != null)
            {
                month1.Items.FindByValue(DateTime.Now.Month.ToString()).Selected = true;
            }
        }


        for (int i = 0; i <= 23; i++)
        {
            h1.Items.Add(new ListItem(i.ToString(), i.ToString()));
            h2.Items.Add(new ListItem(i.ToString(), i.ToString()));
        }

        for (int i = 0; i <= 59; i++)
        {
            m1.Items.Add(new ListItem(i.ToString("00"), i.ToString("00")));
            m2.Items.Add(new ListItem(i.ToString("00"), i.ToString("00")));
        }
        
    }


    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("no");
            l.Text = (e.Row.RowIndex + 1).ToString();
            
            l = (Label)e.Row.FindControl("movecount");
            DateTime d1 = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue), int.Parse(h1.SelectedValue), int.Parse(m1.SelectedValue), 0);
            DateTime d2 = new DateTime(int.Parse(year2.SelectedValue),int.Parse( month2.SelectedValue),int.Parse( day2.SelectedValue),int.Parse( h2.SelectedValue),int.Parse( m2.SelectedValue), 0);
            string[] tmp=DataBase.getTrailerMoveCount(l.Text, d1, d2);
            l.Text = tmp[0];
            l = (Label)e.Row.FindControl("tsum");
            l.Text = tmp[1];
        }
    }

   

    private double GetSum(string name)
    {
        double result = 0;
        double tmp;
        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            Label l = (Label)GridView1.Rows[i].FindControl(name);
            if (double.TryParse(l.Text, out tmp))
            {
                result += tmp;
            }
            
        }
        return result;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">

<table width="100%">
        <tr>
            <td style="text-align:right;">
            <%=DateTime.Now.ToShortDateString() %>
            </td>
            <td style="text-align:left;">
                <%=DateTime.Now.ToShortTimeString() %>
            </td>
                
        </tr>
    </table>
    <table class="LogInTable" align="center">
        <tr>
            <td class="Title">
                تقرير حركات جميع المقطورات/في يوم و فترة وقت محددة
            </td>
        </tr>
        <tr>
            <td>
                <table>
                    <tr class="tr2">
                        <td>من تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                        
                            
                        
                            <asp:DropDownList ID="m1" runat="server">
                            </asp:DropDownList>
                            :
                            <asp:DropDownList ID="h1" runat="server">
                            </asp:DropDownList>
                        </td>
                        <tr>
                            <td>الى تاريخ</td>
                            <td>
                                <asp:DropDownList ID="day2" runat="server">
                                </asp:DropDownList> - 
                                <asp:DropDownList ID="month2" runat="server">
                                </asp:DropDownList> - 
                                <asp:DropDownList ID="year2" runat="server">
                                </asp:DropDownList>
                                
                                 
                                
                                <asp:DropDownList ID="m2" runat="server">
                                </asp:DropDownList>
                                 :
                                <asp:DropDownList ID="h2" runat="server">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton> | <a onclick="window.print();">طباعة</a>
                            </td>
                         </tr>
                                  
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT Number, id FROM Trailer order by Number desc">
        
     </asp:SqlDataSource>
    <asp:GridView AllowSorting="True" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataSourceID="SqlDataSource2" ForeColor="#333333" 
        GridLines="None" 
        Width="90%" onrowdatabound="GridView1_RowDataBound">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" HorizontalAlign="Center" />
        <EmptyDataRowStyle HorizontalAlign="Center" CssClass="Title" />
        <EmptyDataTemplate>
            لا يوجد بيانات
        </EmptyDataTemplate>
        <Columns>
            
            <asp:TemplateField HeaderText="">
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" Text=""></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField HeaderText="رقم المقطورة" DataField="Number" SortExpression="Number" />
            <asp:TemplateField HeaderText="عدد النقلات">
                <ItemTemplate>
                    <asp:Label ID="movecount" runat="server" Text='<%#Eval("id") %>'></asp:Label>
                    
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="مجموع الحمولة">
                <ItemTemplate>
                    <asp:Label ID="tsum" runat="server" Text=""></asp:Label>
                    
                </ItemTemplate>
            </asp:TemplateField>
            
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle HorizontalAlign="Center" BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
    
    <table class="tr1" width="90%">
        <tr>
             <td>
                عدد القاطرات : <%=GridView1.Rows.Count.ToString("###,###,###")%>
              </td>
            <td>
                عدد النقلات : <%=GetSum("movecount") %>
            </td>
            
            <td>
                مجموع اوزان التحميل : <%=GetSum("tsum").ToString("###,###,###")%>
            </td>
            
           
           
        </tr>
    </table>
    
</asp:Content>

