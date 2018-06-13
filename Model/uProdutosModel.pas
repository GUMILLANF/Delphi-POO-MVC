unit uProdutosModel;

interface

uses
  System.SysUtils;

type
  TProduto = class
  private
    FDescricao: String;
    FID: Integer;
    FMarca: String;
    FUnidadeMedida: String;
    FValorVenda: Currency;
    procedure SetDescricao(const Value: String);
  public
    property ID: Integer read FID write FID;
    property Descricao: String read FDescricao write SetDescricao;
    property Marca: String read FMarca write FMarca;
    property UnidadeMedida: String read FUnidadeMedida write FUnidadeMedida;
    property ValorVenda: Currency read FValorVenda write FValorVenda;
  end;

implementation

{ TProduto }

procedure TProduto.SetDescricao(const Value: String);
begin
  if (Value = EmptyStr) then
    raise EArgumentException.Create('''Descrição'' precisa ser preenchido!');
  FDescricao := Value;
end;

end.
