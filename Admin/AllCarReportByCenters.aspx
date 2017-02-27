<%@ Page Title="تقرير حركات حسب المنطقة" Language="C#" MasterPageFile="Reports.master" %>

<script runat="server">

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
            
            for(int i=0;i<24;i++)
            {
                ddlh1.Items.Add(new ListItem(i.ToString(),i.ToString()));
                ddlh2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }
            for (int i = 0; i < 60; i++)
            {
                ddlm1.Items.Add(new ListItem(i.ToString(), i.ToString()));
                ddlm2.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            ddlh2.SelectedValue = "23";
            ddlm2.SelectedValue = "59";
            ddlh1.SelectedValue = "1";
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        DateTime d1=new DateTime(int.Parse(year1.SelectedValue),int.Parse(month1.SelectedValue),int.Parse(day1.SelectedValue),int.Parse(ddlh1.SelectedValue),int.Parse(ddlm1.SelectedValue),0);
        DateTime d2 = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue),int.Parse(ddlh2.SelectedValue),int.Parse(ddlm2.SelectedValue),0);
        Session["d1"]=  d1.ToString();
        Session["d2"] = d2.ToString();
        Session["fid"] = DropDownList1.SelectedValue;
        Session["tid"]= DropDownList2.SelectedValue;
        Session["no"] = TextBox1.Text;
        Response.Redirect("AllCarReportByCenters2.aspx");
        
        
    }


   

    
</script>


<asp:Content ContentPlaceHolderID="Header" ID="c1" runat="server">
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
    <table width="98%" class="LogInTable" align="center">
        <tr>
            <td class="Title">
                تقرير حركات حسب المنطقة
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr class="tr2">
                        <td>من تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                        </td>
                        
                        <td>الى تاريخ</td>
                        <td>
                            <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year2" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td>
                            من
                        </td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [id], [Name] FROM [Centers] ORDER BY [Name]"></asp:SqlDataSource>
                            <asp:DropDownList ID="DropDownList1" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td>
                            الى
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" 
                                DataSourceID="SqlDataSource2" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td>
                            رقم المطالبه 
                        </td>
                        <td>
                             <asp:TextBox Width="50" CssClass="Text" ID="TextBox1" runat="server"></asp:TextBox>
                        </td>
                        
                        
                    </tr>
                    <tr>
                        <td>
                            من الساعة
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlm1" runat="server">
                            </asp:DropDownList>:
                            <asp:DropDownList ID="ddlh1" runat="server">
                            </asp:DropDownList>
                            
                        </td>
                        <td>
                            الى الساعة
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlm2" runat="server">
                            </asp:DropDownList>:
                            <asp:DropDownList ID="ddlh2" runat="server">
                            </asp:DropDownList>
                            
                        </td>
                        <td align="center">
                             <asp:LinkButton ID="LinkButton1" runat="server" onclick="LinkButton1_Click">تنفيذ</asp:LinkButton>
                        </td> 
                    </tr>
                    
                </table>
            </td>
        </tr>
        
    </table>
    
    
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="Body" Runat="Server">
  
</asp:Content>

