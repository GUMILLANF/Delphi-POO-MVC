program Teste;

uses
  Vcl.Forms,
  uFrmListaProdutos in 'View\uFrmListaProdutos.pas' {frmListaProdutos},
  uFrmCadProduto in 'View\uFrmCadProduto.pas' {frmCadProduto},
  uDmConexao in 'DAO\uDmConexao.pas' {DmConexao: TDataModule},
  uDmProduto in 'DAO\uDmProduto.pas' {DmProduto: TDataModule},
  uProdutosController in 'Controller\uProdutosController.pas',
  uProdutosModel in 'Model\uProdutosModel.pas',
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amethyst Kamri');
  Application.CreateForm(TDmConexao, DmConexao);
  Application.CreateForm(TfrmListaProdutos, frmListaProdutos);
  Application.Run;
end.
