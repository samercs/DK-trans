<%@ Page Title="مستخدمين النظام" Language="C#" MasterPageFile="~/Admin/MasterPage.master" %>

<script runat="server">

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[4].Text.Equals("1"))
            {
                e.Row.Cells[4].Text = "مدير للنظام";
            }
            else if(e.Row.Cells[4].Text.Equals("2"))
            {
                e.Row.Cells[4].Text = "مدخل بيانات - العقبة";
            }
            else if (e.Row.Cells[4].Text.Equals("3"))
            {
                e.Row.Cells[4].Text = "مدخل بيانات - عمان";
            }

            HiddenField h = (HiddenField)e.Row.FindControl("id");
            string id = h.Value;
            Image i = (Image)e.Row.FindControl("Image1");
            if (Application["User" + id] != null)
            {
                if (Application["User" + id].Equals("true"))
                {
                    i.ImageUrl = "../Images/OnlineUser.png";
                }
                else
                {
                    i.ImageUrl = "../Images/OfflineUser.png";
                }
            }
            else
            {
                i.ImageUrl = "../Images/OfflineUser.png";
            }

            Label l = (Label)e.Row.FindControl("no");
            l.Text = ((GridView1.PageIndex * GridView1.PageSize) + (e.Row.RowIndex + 1)).ToString();

        }
    }

    protected void ImageButton1_Command(object sender, CommandEventArgs e)
    {
        if (DataBase.Delete("Users", "id", e.CommandArgument.ToString()))
        {
            Message msg = new Message("تم حذف المستخدم", true, "Users.aspx", "Users.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
        else
        {
            Message msg = new Message("لم يخذف المستخدم الرجاء المحاولة في وقت اخر", false, "Users.aspx", "Users.aspx");
            Session["MSG"] = msg;
            Response.Redirect("Message.aspx");
        }
    }

    protected void ImageButton2_Command(object sender, CommandEventArgs e)
    {
        Session["UserId"] = e.CommandArgument.ToString();
        Response.Redirect("UsersEdit.aspx");
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<center>

    <br />
    
    <a href="AddNewUser.aspx">اضافة مستخدم جديد</a>
    
    <br />
    <br />
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:CS %>" 
        SelectCommand="SELECT * FROM [Users]"></asp:SqlDataSource>
    
    
    
    
    <asp:GridView Width="80%" ID="GridView1" runat="server" AutoGenerateColumns="False" 
        CellPadding="4" DataKeyNames="id" DataSourceID="SqlDataSource1" 
        ForeColor="#333333" GridLines="None" onrowdatabound="GridView1_RowDataBound">
        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
        
        <Columns>
            
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="no" runat="server" Text=""></asp:Label>
                    <asp:HiddenField ID="id" Value='<%#Eval("id") %>' runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            
            <asp:BoundField DataField="Name" HeaderText="اسم المستخدم" 
                SortExpression="Name" />
            <asp:BoundField DataField="Username" HeaderText="اسم الدخول" 
                SortExpression="Username" />
            <asp:BoundField DataField="Password" HeaderText="كلمة السر" 
                SortExpression="Password" />
            <asp:BoundField DataField="Type" HeaderText="نوع المستخدم" 
                SortExpression="Type" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Image ID="Image1" Width="25" Height="20" runat="server" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton OnClientClick="return confirm('هل متاكد من تعديل هذا المستخدم');" AlternateText="تعديل" ImageUrl="~/Images/Edit.png" Width="25" Height="20" CommandArgument='<%#Eval("id") %>' ID="ImageButton2" runat="server" OnCommand="ImageButton2_Command" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:ImageButton OnClientClick="return confirm('هل متاكد من حذف هذا المستخدم');" AlternateText="حذف" ImageUrl="~/Images/Delete.png" Width="25" Height="20" CommandArgument='<%#Eval("id") %>' ID="ImageButton1" runat="server" OnCommand="ImageButton1_Command" />
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
<br />
</asp:Content>

