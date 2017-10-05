module Common where

  -- Comandos interactivos o de archivos
  data Stmt i = Def String i           --  Declarar un nuevo identificador x, let x = t
              | Eval i                 --  Evaluar el término
    deriving (Show)
  
  instance Functor Stmt where
    fmap f (Def s i) = Def s (f i)
    fmap f (Eval i)  = Eval (f i)

  -- Tipos de los nombres
  data Name
     =  Global  String
    deriving (Show, Eq)

  -- Entornos
  type NameEnv v t = [(Name, (v, t))]

  -- Tipo de los tipos
  data Type = Base 
            | Unit --Ejercicio6
            | Fun Type Type
            | Pair Type Type --Ejercicio8
            deriving (Show, Eq)
  
  -- Términos con nombres
  data LamTerm  =  LVar String
                |  Abs String Type LamTerm
                |  App LamTerm LamTerm
                |  LtLet String LamTerm LamTerm --Ejercicio3
                |  LtAs LamTerm Type --Ejercicio4
                |  LtUnit --Ejercicio6
                |  LtFst LamTerm --Ejercicio8
                |  LtSnd LamTerm --Ejercicio8
                |  LtPair LamTerm LamTerm --Ejercicio8
                deriving (Show, Eq)


  -- Términos localmente sin nombres
  data Term  = Bound Int
             | Free Name 
             | Term :@: Term
             | Lam Type Term
             | Let Term Term --Ejercicio3
             | As Term Type --Ejercicio4
             | TUnit --Ejercicio6
             | TPair Term Term --Ejercicio8
             | Fst Term --Ejercicio8
             | Snd Term --Ejercicio8
          deriving (Show, Eq)

  -- Valores
  data Value = VLam Type Term 
             | VUnit 
             | VPair Value Value --Ejercicio8

  -- Contextos del tipado
  type Context = [Type]
