object DmProduto: TDmProduto
  OldCreateOrder = False
  Height = 262
  Width = 396
  object sqlPesquisar: TFDQuery
    Connection = DmConexao.sqlConexao
    SQL.Strings = (
      
        'select * from produtos where Descricao like :prodDesc or Id = :i' +
        'd')
    Left = 144
    Top = 128
    ParamData = <
      item
        Name = 'PRODDESC'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
    object sqlPesquisarId: TIntegerField
      FieldName = 'Id'
      Origin = 'Id'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sqlPesquisarDescricao: TWideStringField
      FieldName = 'Descricao'
      Origin = 'Descricao'
      Required = True
      Size = 50
    end
    object sqlPesquisarMarca: TWideStringField
      FieldName = 'Marca'
      Origin = 'Marca'
      Size = 30
    end
    object sqlPesquisarUnidadeMedida: TWideStringField
      FieldName = 'UnidadeMedida'
      Origin = 'UnidadeMedida'
      Size = 3
    end
    object sqlPesquisarValorVenda: TCurrencyField
      FieldName = 'ValorVenda'
      Origin = 'ValorVenda'
    end
  end
  object sqlInserir: TFDQuery
    Connection = DmConexao.sqlConexao
    SQL.Strings = (
      
        'insert into Produtos (ID, Descricao, Marca, UnidadeMedida, Valor' +
        'Venda)'
      'values (:ID, :DESCRICAO, :MARCA, :UN, :VLVENDA)')
    Left = 192
    Top = 128
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'MARCA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'UN'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'VLVENDA'
        DataType = ftCurrency
        ParamType = ptInput
      end>
  end
  object sqlAlterar: TFDQuery
    Connection = DmConexao.sqlConexao
    SQL.Strings = (
      
        'update PRODUTOS set  DESCRICAO = :DESCRICAO, MARCA = :MARCA, UNI' +
        'DADEMEDIDA = :UN , VALORVENDA = :VLVENDA where (ID = :ID)')
    Left = 232
    Top = 128
    ParamData = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'MARCA'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'UN'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'VLVENDA'
        DataType = ftCurrency
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object sqlExcluir: TFDQuery
    Connection = DmConexao.sqlConexao
    SQL.Strings = (
      'delete from PRODUTOS where (ID = :ID)')
    Left = 272
    Top = 128
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
