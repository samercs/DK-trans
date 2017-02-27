<%@ Page Title="مطالبة مالية" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

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
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Session["d1"] = day1.SelectedValue + "/" + month1.SelectedValue + "/" + year1.SelectedValue;
        Session["d2"] = day2.SelectedValue + "/" + month2.SelectedValue + "/" + year2.SelectedValue;
        Session["oldp"] = OldPrices.Text;
        Session["newp"] = NewPrices.Text;
        Session["oldpt"] = NewPricest.Text;
        Session["from"] = from.SelectedValue;
        Session["to"] = to.SelectedValue;
        Response.Redirect("MonyCollect2.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">
    <div class="Title">
    مطالبة مالية 
    </div>
    <table class="LogInTable" align="center">
        <tr class="tr2" style="font-size:12px;">
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
                            السعر القديم
                        </td>
                        <td>
                            <asp:TextBox Width="50" CssClass="Text" ID="OldPrices" runat="server" Text="0.455"></asp:TextBox>
                        </td>
                        <td>
                            السعر الجديد
                        </td>
                        <td>
                            <asp:TextBox Width="50" CssClass="Text" ID="NewPrices" Text="0.465" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            السعر القديم للطن
                        </td>
                        <td>
                            <asp:TextBox Width="50" CssClass="Text" ID="NewPricest" Text="18.4" runat="server"></asp:TextBox>
                        </td>
                        
        </tr>
        <tr>
            <td colspan="9">
                <table align="center">
                    <tr>
                        <td>
                            من
                        </td>
                        <td>
                            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:CS %>" 
                                SelectCommand="SELECT [Name], [id] FROM [Centers] ORDER BY [Name]"></asp:SqlDataSource>
                            <asp:DropDownList ID="from" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        <td>
                            الى
                        </td>
                        <td>
                            <asp:DropDownList ID="to" runat="server" 
                                DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="id">
                            </asp:DropDownList>
                        </td>
                        
                        <td align="center">
                             <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">تنفيذ</asp:LinkButton> |  <a onclick="window.print();">طباعة</a>
                        </td> 
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
    
   
    
  
    
</asp:Content>

