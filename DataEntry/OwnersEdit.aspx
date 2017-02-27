<%@ Page Title="تعديل معلومات المالك" Language="C#" MasterPageFile="~/DataEntry/MasterPage.master" %>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["PID"] != null)
        {
            if (!Page.IsPostBack)
            {
                TextBox1.Text = DataBase.GetPName("Owners", "name", "id", Session["PID"].ToString());
                
            }
        }
        else
        {
            Response.Redirect("Owners.aspx");
        }
    }

    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (DataBase.UpdateData("Owners", new string[] { "name"}, new string[] { TextBox1.Text },"id",Session["PID"].ToString()))
        {
            Message msg = new Message("تم تعديل معلومات المالك", true, "Owners.aspx", "Owners.aspx");
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
        <table align="center" class="LogInTable">
        <tr>
            <td colspan="2" class="Title">
                تعديل معلومات المالك
            </td>
        </tr>
        <tr class="tr2">
            <td>
                اسم المالك 
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ErrorMessage="الرجاء ادخال اسم المالك" Text="*" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
            </td>
            <td>
                <asp:TextBox ID="TextBox1" CssClass="Text" runat="server"></asp:TextBox>
            </td>
        </tr>
        
        <tr>
            <td colspan="2" class="Center">
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">تعديل</asp:LinkButton> | 
                <a href="Owners.aspx">رجوع</a>
                <br />
                <br />
                <asp:ValidationSummary ID="ValidationSummary1" runat="server" />
            </td>
        </tr>
    </table>
    </center>
</asp:Content>

