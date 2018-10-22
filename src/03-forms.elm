import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)

-- MAIN

main =
  Browser.sandbox { init = init, update = update, view = view }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , submitted : Bool
  }

init : Model
init =
  Model "" "" "" False

-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Validate

update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name, submitted = model.submitted && False }
    
    Password password ->
      { model | password = password, submitted = model.submitted && False }

    PasswordAgain password ->
      { model | passwordAgain = password, submitted = model.submitted && False }
    
    Validate ->
      { model | submitted = True }

  
-- VIEW

view : Model -> Html Msg
view model =
  div []
  [ viewInput "text" "Name" model.name Name
  , viewInput "password" "Password" model.password Password
  , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
  , button [ onClick Validate ] [ text "Submit form" ]
  , viewValidation model
  ]

viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
  if model.submitted then
    if model.password == model.passwordAgain then
      div [ style "color" "green" ] [ text "OK" ]
    else
      div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else
    div [] []