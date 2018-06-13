unit uDmProduto;

interface

uses
  System.SysUtils, System.Classes, uDmConexao, Data.FMTBcd, Data.DB,
  Data.SqlExpr, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  uProdutosModel, Datasnap.DBClient, Datasnap.Provider;

type
  TDmProduto = class(TDataModule)
    sqlPesquisar: TFDQuery;
    sqlInserir: TFDQuery;
    sqlAlterar: TFDQuery;
    sqlExcluir: TFDQuery;
    sqlPesquisarId: TIntegerField;
    sqlPesquisarDescricao: TWideStringField;
    sqlPesquisarMarca: TWideStringField;
    sqlPesquisarUnidadeMedida: TWideStringField;
    sqlPesquisarValorVenda: TCurrencyField;
  private
    { Private declarations }
  public
    { Public declarations }
    function GerarID: Integer;
    procedure Pesquisar(sPesq: String; sId: Integer);
    procedure CarregarProduto(oProduto: TProduto; iCodigo: Integer);
    function Inserir(oProduto: TProduto; out sErro: string): Boolean;
    function Alterar(oProduto: TProduto; out sErro: string): Boolean;
    function Excluir(iCodigo: Integer; out sErro: string): Boolean;
  end;

var
  DmProduto: TDmProduto;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmProduto }

function TDmProduto.Alterar(oProduto: TProduto; out sErro: string): Boolean;
begin
  with sqlAlterar, oProduto do
  begin
    Params[0].AsString := Descricao;
    Params[1].AsString := Marca;
    Params[2].AsString := UnidadeMedida;
    Params[3].AsCurrency := ValorVenda;
    Params[4].AsInteger := Id;
    try
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao alterar produto: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

procedure TDmProduto.CarregarProduto(oProduto: TProduto; iCodigo: Integer);
var
  sqlProduto: TFDQuery;
begin
  sqlProduto := TFDQuery.Create(nil);
  try
    sqlProduto.Connection := DmConexao.sqlConexao;
    sqlProduto.SQL.Clear;
    sqlProduto.SQL.Add('select * from produtos where id = ' + IntToStr(iCodigo));
    sqlProduto.Open;
    with oProduto do
    begin
      Id := sqlProduto.FieldByName('ID').AsInteger;
      Descricao := sqlProduto.FieldByName('Descricao').AsString;
      Marca := sqlProduto.FieldByName('Marca').AsString;
      UnidadeMedida := sqlProduto.FieldByName('UnidadeMedida').AsString;
      ValorVenda := sqlProduto.FieldByName('ValorVenda').AsCurrency;
    end;
  finally
    FreeAndNil(sqlProduto);
  end;
end;

function TDmProduto.Excluir(iCodigo: Integer; out sErro: string): Boolean;
begin
  with sqlExcluir do
  begin
    Params[0].AsInteger := iCodigo;
    try
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao excluir o produto ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDmProduto.GerarID: Integer;
var
  sqlSequencia: TFDQuery;
begin
  sqlSequencia := TFDQuery.Create(nil);
  try
    with sqlSequencia do
    begin
      Connection := DmConexao.sqlConexao;
      SQL.Clear;
      SQL.Add('select isnull(max(id), 0) + 1 as seq from produtos');
      Open;
      Result := FieldByName('seq').AsInteger;
    end;
  finally
    FreeAndNil(sqlSequencia);
  end;
end;

function TDmProduto.Inserir(oProduto: TProduto; out sErro: string): Boolean;
begin
  with sqlInserir, oProduto do
  begin
    ID := GerarID;
    Params[0].AsInteger := ID;
    Params[1].AsString := Descricao;
    Params[2].AsString := Marca;
    Params[3].AsString := UnidadeMedida;
    Params[4].AsCurrency := ValorVenda;
    try
      ExecSQL();
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Ocorreu um erro ao inserir produto: ' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

procedure TDmProduto.Pesquisar(sPesq: String; sId: Integer);
begin
  sqlPesquisar.Close;
  sqlPesquisar.ParamByName('PRODDESC').AsString := sPesq;
  sqlPesquisar.ParamByName('ID').AsInteger := sId;
  sqlPesquisar.Active:= True;
  sqlPesquisar.First;
end;

end.
