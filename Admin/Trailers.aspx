<%@ Page Title="المقطورات" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        Session["PID"] = e.CommandArgument.ToString();
        Response.Redirect("TrailersEdit.aspx");
    }

    protected void ImageButton2_Command(object sender, CommandEventArgs e)
    {
         System.Data.DataTable dt = DataBase.GetData("Transports", new string[] {"Trailerid" }, new string[] {e.CommandArgument.ToString() });
         if (dt.Rows.Count == 0)
         {
             if (DataBase.Delete("Trailer", "id", e.CommandArgument.ToString()))
             {
                 Message msg = new Message("تم حذف المقطورة", true, "Trailers.aspx", "Trailers.aspx");
                 Session["MSG"] = msg;
                 Response.Redirect("Message.aspx");
             }
             else
             {
                 Message msg = new Message("خطا في النظام الرجاء المحاولة مرة اخرى", false, "Trailers.aspx", "Trailers.aspx");
                 Session["MSG"] = msg;
                 Response.Redirect("Message.aspx");
             }
         }
         else
         {
             Message msg = new Message("يوجد حمولات مدخلة برقم هذة المقطورة . لا يمكن حذف هذة المقطورة", false, "Trailers.aspx", "Trailers.aspx");
             Session["MSG"] = msg;
             Response.Redirect("Message.aspx");
         }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label l = (Label)e.Row.FindControl("no");
            l.Text = ((GridView1.PageIndex * GridView1.PageSize) + (e.Row.RowIndex + 1)).ToString();
            
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
    

<center>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        
        SelectCommand="SELECT Trailer.id, Trailer.Number, Trailer.Owner, Owners.Name FROM Trailer INNER JOIN Owners ON Trailer.Owner = Owners.ID ORDER BY Owners.Name, Trailer.Number"></asp:SqlDataSource>
    <br />
    <br />
    <a href="TrailersAdd.aspx">اضافة مقطورة جديدة</a>
    <br />
    <br />
    
    <asp:GridView Width="90%" ID="GridView1" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
        DataKeyNames="id" DataSourceID="SqlDataSource1" ForeColor="#333333" 
        GridLines="None" PageSize="20" OnRowDataBound="GridView1_RowDataBound">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" Text=""></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="Number" HeaderText="رقم القاطرة" SortExpression="Number" />
            <asp:BoundField DataField="Name" HeaderText="المالك" SortExpression="Name" />
           
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Edit.png" Width="25" Height="20" ID="ImageButton1" runat="server" OnCommand="ImageButton1_Command" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton CommandArgument='<%#Eval("id") %>' ImageUrl="~/Images/Delete.png" Width="25" Height="20" OnClientClick="return confirm('هل متاكد من حذف القاطرة');" ID="ImageButton2" runat="server" OnCommand="ImageButton2_Command" />
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

</ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

