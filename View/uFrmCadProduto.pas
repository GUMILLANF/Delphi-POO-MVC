unit uFrmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, uProdutosController,
  System.ImageList, Vcl.ImgList;

type
  TOperacao = (OpNovo, OpAlterar, OpNavegar);
  TfrmCadProduto = class(TForm)
    pnlBtnCad: TPanel;
    btnListar: TButton;
    btnAlterar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtMarca: TLabeledEdit;
    edtUnidadeMedida: TLabeledEdit;
    edtValorVenda: TMaskEdit;
    Label1: TLabel;
    ImageList1: TImageList;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnListarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtValorVendaExit(Sender: TObject);
    procedure edtValorVendaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Listar;
    procedure Alterar;
    procedure Inserir;
    procedure Gravar;
    procedure LimparCampos;
  public
    { Public declarations }
    Codigo: Integer;
    FOperacao: TOperacao;
    oProdutoControllerCad: TProdutosController;
    procedure HabilitarControles(aOperacao: TOperacao);
    procedure CarregarProduto;
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

uses uProdutosModel;

{ TfrmCadProduto }

procedure TfrmCadProduto.Alterar;
var
  oProduto: TProduto;
  sErro: string;
begin
  oProduto := TProduto.Create;
  try
    with oProduto do
    begin
      ID := StrToIntDef(edtCodigo.Text, 0);
      Descricao := edtDescricao.Text;
      Marca := edtMarca.Text;
      UnidadeMedida := edtUnidadeMedida.Text;
      ValorVenda := StrToCurr(edtValorVenda.Text);
    end;
    if oProdutoControllerCad.Alterar(oProduto, sErro) = False then
      raise Exception.Create(sErro)
    else
      ShowMessage('Produto Alterado com Sucesso!');
  finally
    FreeAndNil(oProduto);
  end;
end;

procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if edtCodigo.Text = '' then
  begin
    ShowMessage('Não tem registro carregado para realizar alteração!');
    exit;
  end;
  FOperacao := OpAlterar;
  HabilitarControles(OpAlterar);
end;

procedure TfrmCadProduto.btnCancelarClick(Sender: TObject);
begin
  HabilitarControles(OpNavegar);
  LimparCampos;
end;

procedure TfrmCadProduto.btnGravarClick(Sender: TObject);
begin
  if edtDescricao.Text = '' then
  begin
    ShowMessage('O campo descrição é obrigatório!');
    exit;
  end;
  Gravar;
  HabilitarControles(OpNavegar);
end;

procedure TfrmCadProduto.btnListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TfrmCadProduto.CarregarProduto;
var
  oProduto: TProduto;
begin
  oProduto := TProduto.Create;
  try
    oProdutoControllerCad.CarregarProduto(oProduto, Codigo);
    with oProduto do
    begin
      edtCodigo.Text := IntToStr(ID);
      edtDescricao.Text := Descricao;
      edtMarca.Text := Marca;
      edtUnidadeMedida.Text := UnidadeMedida;
      edtValorVenda.Text := CurrToStr(ValorVenda);
    end;
  finally
    FreeAndNil(oProduto);
  end;
end;

procedure TfrmCadProduto.edtValorVendaExit(Sender: TObject);
begin
  if edtValorVenda.Text = '' then
    edtValorVenda.Text := '0';
  edtValorVenda.Text := CurrToStrF(StrToCurr(Trim(edtValorVenda.Text)),ffFixed,2);
end;

procedure TfrmCadProduto.edtValorVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',',',#8]) then
    key :=#0;
end;

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LimparCampos;
end;

procedure TfrmCadProduto.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmCadProduto.Gravar;
begin
  try
    case FOperacao of
      OpNovo: Inserir;
      OpAlterar: Alterar;
    end;
  finally
  end;
end;

procedure TfrmCadProduto.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
    OpNovo, OpAlterar:
    begin
      edtDescricao.Enabled := True;
      edtMarca.Enabled := True;
      edtUnidadeMedida.Enabled := True;
      edtValorVenda.Enabled := True;
      btnListar.Enabled := False;
      btnAlterar.Enabled := False;
      btnGravar.Enabled := True;
      btnCancelar.Enabled := True;
    end;
    OpNavegar:
    begin
      edtDescricao.Enabled := False;
      edtMarca.Enabled := False;
      edtUnidadeMedida.Enabled := False;
      edtValorVenda.Enabled := False;
      btnListar.Enabled := True;
      btnAlterar.Enabled := True;
      btnGravar.Enabled := False;
      btnCancelar.Enabled := False;
    end;
  end;
end;

procedure TfrmCadProduto.Inserir;
var
  oProduto: TProduto;
  sErro: string;
begin
  oProduto := TProduto.Create;
  try
    with oProduto do
    begin
      ID := 0;
      Descricao := edtDescricao.Text;
      Marca := edtMarca.Text;
      UnidadeMedida := edtUnidadeMedida.Text;
      ValorVenda := StrToCurr(edtValorVenda.Text);
      Codigo := ID;
    end;
    if oProdutoControllerCad.Inserir(oProduto, sErro) = False then
      raise Exception.Create(sErro)
    else
    begin
      ShowMessage('Produto cadastrado com sucesso!');
      Codigo := oProduto.ID;
      CarregarProduto;
    end

  finally
    FreeAndNil(oProduto);
  end;
end;

procedure TfrmCadProduto.LimparCampos;
begin
  edtCodigo.Clear;
  edtDescricao.Clear;
  edtUnidadeMedida.Clear;
  edtMarca.Clear;
  edtValorVenda.Clear;
end;

procedure TfrmCadProduto.Listar;
begin
  close;
end;

end.
