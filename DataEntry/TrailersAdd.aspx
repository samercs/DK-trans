<%@ Page Title="اضافة مقطورة جديدة" Language="C#" MasterPageFile="MasterPage.master" %>

<script runat="server">

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        Page.Validate();
        if (Page.IsValid)
        {
            if (DataBase.Insert("Trailer", new string[] { "Number", "Owner" }, new string[] { TextBox1.Text, DropDownList1.SelectedValue }))
            {
                Message msg = new Message("تم اضافة المقطورة", true, "Trailers.aspx", "Trailers.aspx");
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
    }

    protected void CustomValidator1_ServerValidate(object source, ServerValidateEventArgs args)
    {
        if (DataBase.GetPName("Trailer", "Number", "Number", TextBox1.Text).Trim().Length != 0)
        {
            args.IsValid = false;
        }
        else
        {

            args.IsValid = true;
        }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <ContentTemplate>
    
    
<center>
    
    <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">
                ادخال مقطورة جديدة
            </td>
        </tr>
        <tr class="tr2">
            <td>
                رقم المقطورة
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال رقم المقطورة" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                <asp:CustomValidator ControlToValidate="TextBox1" ID="CustomValidator1" Text="*" runat="server" ErrorMessage="رقم المقطورة مدخل" OnServerValidate="CustomValidator1_ServerValidate"></asp:CustomValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        
         <tr class="tr2">
            <td>
                المالك
                
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    DataSourceID="SqlDataSource1" DataTextField="Name" DataValueField="ID">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:CS %>" 
                    SelectCommand="SELECT [ID], [Name] FROM [Owners]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">اضافة</asp:LinkButton> | 
                <a href="Trailers.aspx">رجوع</a>
                <br />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    
</center>

</ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>

