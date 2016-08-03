module View.Color exposing (..)

import Model.Part exposing (..)


palette : List String
palette =
  [ "#1f78b4"
  , "#b2df8a"
  , "#33a02c"
  , "#a6cee3"
  ] -- colorblind safe according to http://colorbrewer2.org/?type=qualitative&scheme=Paired&n=4

-- pretty but probably not colorblind safe
  -- [ "#3cab5c"
  -- , "rgb(160,61,80)"
  -- , "rgb(90,60,240)"
  -- , "rgb(15,36,40)"
  -- , "rgb(27,61,15)"
  -- ]


partColor : List Part -> Part -> String
partColor parts part =
  List.map2 (,) parts palette
  |> List.filter (\(p,color) -> p.name==part.name)
  |> List.map (\(_,color) -> color)
  |> List.head
  |> Maybe.withDefault "red"
