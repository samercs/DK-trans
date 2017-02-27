<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Reports.master" %>

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



    protected void Button1_Click(object sender, EventArgs e)
    {
        DateTime tmp = new DateTime(int.Parse(year1.SelectedValue), int.Parse(month1.SelectedValue), int.Parse(day1.SelectedValue));
        DateTime d1 = new DateTime(tmp.Year, tmp.Month, tmp.Day);
        tmp = new DateTime(int.Parse(year2.SelectedValue), int.Parse(month2.SelectedValue), int.Parse(day2.SelectedValue));
        DateTime d2 = new DateTime(tmp.Year, tmp.Month, tmp.Day);
        SqlDataSource1.SelectParameters["d1"].DefaultValue = d1.ToString();
        SqlDataSource1.SelectParameters["d2"].DefaultValue = d2.ToString();

        SqlDataSource1.DataBind();
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label tmp = (Label)e.Row.FindControl("Label1");
            tmp.Text = DataBase.GetPName("Drivers", "name", "id", tmp.Text);

            tmp = (Label)e.Row.FindControl("Label2");
            tmp.Text = DataBase.GetPName("Cars", "Number", "id", tmp.Text);

            tmp = (Label)e.Row.FindControl("Label3");
            tmp.Text = DataBase.GetPName("Centers", "name", "id", tmp.Text);

            tmp = (Label)e.Row.FindControl("Label4");
            tmp.Text = DataBase.GetPName("Centers", "name", "id", tmp.Text);

            tmp = (Label)e.Row.FindControl("Label5");
            tmp.Text = (e.Row.RowIndex + 1).ToString();
            
        }
    }


    private double GetSum(int Index)
    {
        double result = 0;

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            if (GridView1.Rows[i].RowType == DataControlRowType.DataRow)
            {
                string x = GridView1.Rows[i].Cells[Index].Text.Replace(",", "");
                double tmp;
                if (double.TryParse(x, out tmp))
                {
                    result += tmp;
                }
            }
        }

        return result;
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="Header" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="Body" Runat="Server">
        <table align="center">
            <tr>
                <td style="background-color:#C9BE62;border:solid 1px black;font-size:24px;">
                    تقرير كوبون فئة 330 لتر في فترة محددة / كل القاطرات
                </td>
            </tr>
        </table>
        <br /><br />
        <table>
            <tr style="font-size:18px;">
                <td style="background-color:#ADA96E;border:solid 1px black;">
                    تقرير الكابونات في الفترة 
                </td>
                <td style="background-color:#FBB117;border:solid 1px black;">
                    من :-
                </td>
                <td style="background-color:#FBB117;border:solid 1px black;">
                     <asp:DropDownList ID="day1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month1" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year1" runat="server">
                            </asp:DropDownList>
                </td>
                <td style="background-color:#FBB117;border:solid 1px black;">
                    الى :- 
                </td>
                <td style="background-color:#FBB117;border:solid 1px black;">
                    <asp:DropDownList ID="day2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="month2" runat="server">
                            </asp:DropDownList> - 
                            <asp:DropDownList ID="year2" runat="server">
                            </asp:DropDownList>
                </td>
            </tr>
            <tr style="font-size:18px;">
                <td colspan="" style="background-color:#FBB117;border:solid 1px black;">
                    فئة الكوبون 330 لتر
                    
                </td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="تنفيذ" OnClick="Button1_Click" />
                </td>
            </tr>
        </table>
        <br />
        <br />
    <asp:GridView Font-Size="18px" Width="90%" GridLines="Both" HeaderStyle-BackColor="#ADA96E"  AutoGenerateColumns="false" DataSourceID="SqlDataSource1" ID="GridView1" runat="server" OnRowDataBound="GridView1_RowDataBound">
        <Columns>
            <asp:TemplateField ItemStyle-BackColor="#ADA96E" HeaderText="رقم">
                <ItemTemplate>
                    <asp:Label ID="Label5" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="No" HeaderText="رقم الكابون" />
            <asp:BoundField DataField="Type" HeaderText="فئة الكابون" />
            <asp:BoundField DataField="loadno" HeaderText="رقم التحميل" />
            <asp:BoundField DataField="LeavingTime1"  DataFormatString="{0:dd/MM/yyyy&nbsp;&nbsp;hh:mm}" HeaderText="تاريخ التحميل" />
            <asp:TemplateField HeaderText="اسم السائق">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%#Eval("Driverid") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="رقم القاطرة">
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%#Eval("Carid") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="من">
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%#Eval("Fromid") %>'></asp:Label>
                </ItemTemplate>
                
            </asp:TemplateField>
            <asp:TemplateField HeaderText="الى">
                <ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%#Eval("toid") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        
        
        
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:CS %>" 
            SelectCommand="SELECT TransCapon.No, TransCapon.Type, Transports.DriverId, Transports.CarID, Transports.FromId, Transports.ToId, Transports.LeavingTime1, Transports.LoadNo FROM TransCapon INNER JOIN Transports ON TransCapon.TransID = Transports.id where (DATEDIFF(dd, Transports.LeavingTime1, @d1) &lt;= 0) AND (DATEDIFF(dd, Transports.LeavingTime1, @d2) &gt;= 0 and (transcapon.type=330))">
            
         <SelectParameters>
                        <asp:Parameter Name="d1" />
                        <asp:Parameter Name="d2" />
         </SelectParameters>
            
    </asp:SqlDataSource>
       
       
       <br />
       <br />
       
        <table width="50%" style="background-color:#FBB917;font-size:18px;">
            <tr>
                <td>
                    عدد الكابونات
               
                    <%=GridView1.Rows.Count %>
                </td>
                
                <td>
                    المجموع
                
                    <%=GetSum(2).ToString("###,###,###") %> لتر
                </td>
            </tr>
        </table>    
        
</asp:Content>

