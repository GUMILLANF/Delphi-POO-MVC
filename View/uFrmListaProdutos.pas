unit uFrmListaProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, uDmProduto, uDmConexao, Data.FMTBcd, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client, uProdutosController,
  System.ImageList, Vcl.ImgList;

type
  TfrmListaProdutos = class(TForm)
    pnlFiltro: TPanel;
    edtPesquisar: TLabeledEdit;
    btnPesquisar: TButton;
    grdProdutos: TDBGrid;
    pnlBtnPesq: TPanel;
    btnNovo: TButton;
    btnDetalhar: TButton;
    btnExcluir: TButton;
    dsPesq: TDataSource;
    ImageList1: TImageList;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnDetalharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Public declarations }
    procedure Pesquisar;
    procedure Novo;
    procedure Detalhar;
    procedure Excluir;
  end;

var
  frmListaProdutos: TfrmListaProdutos;
  oProdutosController: TProdutosController;

implementation

{$R *.dfm}

uses uFrmCadProduto;

{ TfrmListaProdutos }

procedure TfrmListaProdutos.btnDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmListaProdutos.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmListaProdutos.btnNovoClick(Sender: TObject);
begin
  Novo;
end;

procedure TfrmListaProdutos.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmListaProdutos.Detalhar;
begin
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  with frmCadProduto do
  begin
    FOperacao := OpNavegar;
    HabilitarControles(OpNavegar);
    oProdutoControllerCad := oProdutosController;
    Codigo := DmProduto.sqlPesquisarID.AsInteger;
    CarregarProduto;
    ShowModal;
  end;
  FreeAndNil(frmCadProduto);
  Pesquisar;
end;

procedure TfrmListaProdutos.Excluir;
var
  sErro: string;
  _cod: Integer;
begin
  try
    if (DmProduto.sqlPesquisar.Active) and (DmProduto.sqlPesquisar.RecordCount > 0) then
    begin
      if MessageDlg('Deseja realmente excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = IDYES then
      begin
        if oProdutosController.Excluir(DmProduto.sqlPesquisarID.AsInteger, sErro) = false then
          raise Exception.Create(sErro);
        try
          _cod := StrToInt(edtPesquisar.Text);
        Except
          _cod := 0;
        end;
        oProdutosController.Pesquisar('%' + edtPesquisar.Text + '%', _cod);
      end;
    end
    else
      raise Exception.Create('Não há registro para ser excluido!');
  finally
  end;
end;

procedure TfrmListaProdutos.FormActivate(Sender: TObject);
begin
  oProdutosController := TProdutosController.Create;
  Pesquisar;
end;

procedure TfrmListaProdutos.Novo;
begin
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  with frmCadProduto do
  begin
    FOperacao := OpNovo;
    HabilitarControles(OpNovo);
    oProdutoControllerCad := oProdutosController;
    ShowModal;
  end;
  FreeAndNil(frmCadProduto);
  Pesquisar;
end;

procedure TfrmListaProdutos.Pesquisar;
var
  _cod: Integer;
  sErro: String;
begin

  try
    try
      _cod := StrToInt(edtPesquisar.Text);
    Except
      _cod := 0;
    end;
    oProdutosController.Pesquisar('%' + edtPesquisar.Text + '%', _cod);
  finally
  end;
end;

end.
