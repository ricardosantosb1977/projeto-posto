unit Classe.Helper;

interface

uses Vcl.StdCtrls, System.SysUtils;

type
  TEditHelper = class helper for TEdit
    function IsEmpty: Boolean;
  end;

implementation

{ TEditHelper }

function TEditHelper.IsEmpty: Boolean;
begin
  Result := Trim(Self.Text) = EmptyStr;
end;

end.
