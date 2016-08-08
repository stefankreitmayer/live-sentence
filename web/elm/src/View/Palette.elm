module View.Palette exposing (..)

import Model.Part exposing (..)


-- colorblind safe according to http://colorbrewer2.org/?type=qualitative&scheme=Paired&n=4
-- palette : List String
-- palette =
--   [ "#1f78b4"
--   , "#b2df8a"
--   , "#33a02c"
--   , "#a6cee3"
--   ]

-- for black text. probably not colorblind safe
palette : List String
palette =
  [ "#ef476f"
  , "#ffd166"
  , "#06d6a0"
  , "#118ab2"
  , "#073b4c"
  ]


-- -- pretty but probably not colorblind safe
-- palette : List String
-- palette =
--   [ "#3cab5c"
--   , "rgb(160,61,80)"
--   , "rgb(90,60,240)"
--   , "rgb(15,36,40)"
--   , "rgb(27,61,15)"
--   ]


partColor : List Part -> Part -> String
partColor parts part =
  List.map2 (,) parts palette
  |> List.filter (\(p,color) -> p.name==part.name)
  |> List.map (\(_,color) -> color)
  |> List.head
  |> Maybe.withDefault "red"
