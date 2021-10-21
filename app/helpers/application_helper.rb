module ApplicationHelper
  def campus_list
    list = [
      ["Reitoria", "Reitoria"],
      ["Angical", "Angical"],
      ["Cocal", "Cocal"],
      ["Dirceu Arcoverde", "Dirceu Arcoverde"],
      ["José de Freitas", "José de Freitas"],
      ["Parnaíba", "Parnaíba"],
      ["Pedro II", "Pedro II"],
      ["Pio IX", "Pio IX"],
      ["São João", "São João"],
      ["Teresina Central", "Teresina Central"],
      ["Uruçuí", "Uruçuí"],
      ["Campo Maior", "Campo Maior"],
      ["Corrente", "Corrente"],
      ["Floriano", "Floriano"],
      ["Oeiras", "Oeiras"],
      ["Paulistana", "Paulistana"],
      ["Picos", "Picos"],
      ["Piripiri", "Piripiri"],
      ["São Raimundo Nonato", "São Raimundo Nonato"],
      ["Teresina Zona Sul", "Teresina Zona Sul"],
      ["Valença","Valença"]]
    return list
  end

  def l_boolean(boolean)
    (boolean) ? t("yes") : t("no")
  end
end
