module type Ops =
sig
  type 'a m

  (** Throw an exception to be captured within the monad. *)
  val throw : exn -> 'a m

  (** Handle an exception within the monad. *)
  val catch : 'a m -> (('a, exn) Result.t -> 'b m) -> 'b m
end

module type T =
sig
  include Monad.Trans
  include Ops with type 'a m := 'a m

  val run : 'a m -> (('a, exn) Result.t -> 'b n) -> 'b n
  val run_exn : 'a m -> 'a n
end

module type S = T with type 'a n = 'a

module MakeT (M : Monad.S) : T with type 'a n = 'a M.m
module M : T with type 'a n = 'a
