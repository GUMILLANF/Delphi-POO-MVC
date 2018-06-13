unit uProdutosController;

interface

uses
  uProdutosModel, uDmProduto, System.SysUtils;

type
  TProdutosController = class
  public
    constructor Create;
    procedure Pesquisar(sPesq: String; sId: Integer);
    procedure CarregarProduto(oProduto: TProduto; iCodigo: Integer);
    function Inserir(oProduto: TProduto; var sErro: string): Boolean;
    function Alterar(oProduto: TProduto; var sErro: string): Boolean;
    function Excluir(iCodigo: Integer; var sErro: string): Boolean;
  end;

implementation

{ TProdutosController }

function TProdutosController.Alterar(oProduto: TProduto;
  var sErro: string): Boolean;
begin
  Result := DmProduto.Alterar(oProduto, sErro);
end;

procedure TProdutosController.CarregarProduto(oProduto: TProduto;
  iCodigo: Integer);
begin
  DmProduto.CarregarProduto(oProduto, iCodigo);
end;

constructor TProdutosController.Create;
begin
  DmProduto := TDmProduto.Create(nil);
end;

function TProdutosController.Excluir(iCodigo: Integer;
  var sErro: string): Boolean;
begin
  Result := DmProduto.Excluir(iCodigo, sErro);
end;

function TProdutosController.Inserir(oProduto: TProduto;
  var sErro: string): Boolean;
begin
  Result := DmProduto.Inserir(oProduto, sErro);
end;

procedure TProdutosController.Pesquisar(sPesq: String; sId: Integer);
begin
  DmProduto.Pesquisar(sPesq, sId);
end;

end.
