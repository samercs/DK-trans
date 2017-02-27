<%@ Page Title="اصحاب الشاحنات" Language="C#" MasterPageFile="~/DataEntry/MasterPage.master" %>

<script runat="server">

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        Session["PID"] = e.CommandArgument.ToString();
        Response.Redirect("OwnersEdit.aspx");
    }

    protected void ImageButton2_Command(object sender, CommandEventArgs e)
    {
        if (DataBase.Delete("Owners", "id", e.CommandArgument.ToString()))
        {
            Message msg = new Message("تم حذف المالك", true, "Owners.aspx", "Owners.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
        else
        {
            Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "Owners.aspx", "Owners.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<center>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT * FROM [Owners] ORDER BY [Name]"></asp:SqlDataSource>
    <br />
    <br />
    <a href="OwnersAdd.aspx">اضافة مالك جديد</a>
    <br />
    <br />
    
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None" PageSize="30">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:BoundField DataField="Name" HeaderText="الاسم" SortExpression="Name" />
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Edit.png" Width="25" Height="20" ID="ImageButton1" runat="server" OnCommand="ImageButton1_Command" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Delete.png" Width="25" Height="20" OnClientClick="return confirm('هل متاكد من حذف المالك');" ID="ImageButton2" runat="server" OnCommand="ImageButton2_Command" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
        <EditRowStyle BackColor="#999999" />
        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
    </asp:GridView>
</center>
</asp:Content>

