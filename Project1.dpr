program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  Math;

type
  TDropItem = class
    Name: String;

    Weight: Single;

    CountMin: Integer;
    CountMax: Integer;
    Counter: Integer;

    constructor Create(AName: String; AWeight: Single; AMin, AMax: Integer);
  end;

function GetItemFromDropSubList(AWeight: Single; ASubList: TList<TDropItem>; out AItem: TDropItem): Boolean;
var i: Integer;
    W: Single;
begin

  Result := False;

  W := AWeight;

//  Writeln('ww -> ', W:3:3);

  for i := 0 to ASubList.Count - 1 do
    begin

      if ASubList[i].Weight >= W then
        begin
          AItem := ASubList[i];
//          Writeln('OK... ', ASubList[i].Name);
          Result := True;
          Break;
        end

      else
        begin
          W := W - ASubList[i].Weight;
        end;

//      Writeln('WWW   ', ASubList[i].Name, ' -> ', W:3:3);
    end;

//  Writeln('#####');
end;

var
  DropSubList: TList<TDropItem>;
  DropList: TList<TList<TDropItem>>;

  DSI: TList<TDropItem>;
  DI: TDropItem;

  W, GroupWeight, MaxWeight: Single;

  N: Integer;

  i, j: Integer;

{ TDropItem }

constructor TDropItem.Create(AName: String; AWeight: Single; AMin, AMax: Integer);
begin
  Name := AName;
  Weight := AWeight;
  CountMin := AMin;
  CountMax := AMax;
end;

begin

  Randomize;

  DropList := TList<TList<TDropItem>>.Create;

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Какая-то нужная хрень', 100, 5, 10));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Денюшка', 75, 1000, 1500));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Ветка', 50, 1, 7));
  DropSubList.Add(TDropItem.Create('Шкурка', 20, 2, 5));
  DropSubList.Add(TDropItem.Create('Уголь', 17, 2, 6));
  DropSubList.Add(TDropItem.Create('Кость', 10, 4, 15));
  DropSubList.Add(TDropItem.Create('Сталь', 3, 1, 3));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
//  DropSubList.Add(TDropItem.Create('Непонятно что, но надо', 97, 10, 12));
  DropSubList.Add(TDropItem.Create('Заточка брони', 2, 1, 3));
  DropSubList.Add(TDropItem.Create('Заточка оружия', 1, 1, 1));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Броня1', 0.8, 1, 1));
  DropSubList.Add(TDropItem.Create('Броня2', 0.8, 1, 1));
  DropSubList.Add(TDropItem.Create('Броня3', 0.8, 1, 1));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Оружие1', 0.5, 1, 1));
  DropSubList.Add(TDropItem.Create('Оружие2', 0.3, 1, 1));
  DropList.Add(DropSubList);

  MaxWeight := 0;
  for DSI in DropList do
    begin
      GroupWeight := 0;
      for DI in DSI do
        begin
          GroupWeight := GroupWeight + DI.Weight;
          Writeln(DI.Name, ': (', DI.CountMin, '-', DI.CountMax, ')', ' -> ', DI.Weight:3:3);
        end;

      if MaxWeight < GroupWeight then
        MaxWeight := GroupWeight;

//      Writeln('Group Weight: ', GroupWeight:3:3);
      Writeln('');
    end;

  Writeln('#######################################################');
  Writeln('Max Groups Weight: ', MaxWeight:3:3);
  Writeln('#######################################################');
  Writeln('');


  N := 300;

  for j := 0 to N - 1 do
    begin
      W := Random * MaxWeight;
//      Writeln(W:3:10);

      for i := 0 to DropList.Count - 1 do
        begin
          if GetItemFromDropSubList(W, DropList[i], DI) then
            begin
              DI.Counter := DI.Counter + 1;
//              Writeln('Выпало: ', DI.Name, ' (', RandomRange(DI.CountMin, DI.CountMax), ') шт.');
            end;
        end;
//      Writeln('-------------------------------------------------------');
//      Writeln('');

    end;

  for DSI in DropList do
    begin
      for DI in DSI do
        Writeln(DI.Name, ' : ', DI.Counter, ' -> ', DI.Counter / N * 100:3:3);

      Writeln('');
    end;

  FreeAndNil(DropList);

  Readln;

end.
