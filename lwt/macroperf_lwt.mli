open Macroperf

module Perf_wrapper : sig
  (** Wrapper for the PERF-STAT(1) command. *)

  val run :
    ?env:string list ->
    ?evts:string list ->
    ?nb_iter:int ->
    string list -> Result.Execution.t Lwt.t
    (** [run ?env ?evts ?nb_iter cmd] is a thread that will launch
        [cmd] in perf -- asking perf to run it [nb_iter] times
        (default: 1). *)
end

module Runner : sig
  exception Not_implemented
  (** Raised when the implementation of the measurement for a
      requested topic is missing. *)

  val run_exn :
    ?nb_iter:int ->
    ?topics:Topic.t list ->
    Benchmark.t ->
    Result.t Lwt.t
  (** [run_exn ?nb_iter ?topics b] is a thread that will run [b]
      [nb_iter] times (default: 1) and return the a result value. If
      [?topics] is set, the benchmark will be performed on [topics],
      otherwise the list of topics to benchmark is taken from [b]. *)

  val run :
    ?nb_iter:int ->
    ?topics:Topic.t list ->
    Benchmark.t ->
    Result.t option Lwt.t
    (** Like the above but never throw an exception. *)
end
