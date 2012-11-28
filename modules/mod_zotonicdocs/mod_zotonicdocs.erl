%% @doc Module for serving and regenerating the zotonic documentation
%% (github webhook).

%% Copyright Arjan Scherpenisse
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(mod_zotonicdocs).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

-behaviour(gen_server).

-mod_title("Zotonic documentation").
-mod_description("Serves and regenerates the Zotonic documentation.").
-mod_prio(50).

%% gen_server exports
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([start_link/1]).

%% interface functions
-export([
         event/2,
         make/1,
         pid_observe_zotonicdocs_make/3
]).

-include_lib("zotonic.hrl").

-record(state, {context}).

%%====================================================================
%% API
%%====================================================================

%% @doc Starts the server
start_link(Args) when is_list(Args) ->
    gen_server:start_link(?MODULE, Args, []).

event(#postback{message=make}, Context) ->
    make(Context),
    z_render:growl("Building the documentation. This can take a while.", Context).

make(Context) ->
    z_notifier:notify(zotonicdocs_make, Context).

pid_observe_zotonicdocs_make(Pid, zotonicdocs_make, _Context) ->
     gen_server:cast(Pid, make).


%%====================================================================
%% gen_server callbacks
%%====================================================================

%% @spec init(Args) -> {ok, State} |
%%                     {ok, State, Timeout} |
%%                     ignore               |
%%                     {stop, Reason}
%% @doc Initiates the server.
init(Args) ->
    {context, Context} = proplists:lookup(context, Args),
    {ok, #state{
        context  = z_context:new(Context)
    }}.


handle_call(Message, _From, State) ->
    {stop, {unknown_call, Message}, State}.


handle_cast(make, State) ->
    do_make(State#state.context),
    {noreply, State};

handle_cast(Message, State) ->
    {stop, {unknown_cast, Message}, State}.


handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


%%====================================================================
%% support functions
%%====================================================================

do_make(Context) ->
    Root = root(Context),
    ensure_checkout(Root, Context),
    make_html(Root, Context),
    make_edocs(Root, Context),
    ok.

root(Context) ->
    z_path:files_subdir_ensure("zotonicdocs", Context).

ensure_checkout(RootDir, Context) ->
    case filelib:is_dir(filename:join(RootDir, "zotonic/.git")) of
        true ->
            ?zInfo("Updating zotonic", Context),
            os:cmd("cd " ++ z_utils:os_escape(filename:join(RootDir, "zotonic")) ++ " && git reset --hard && git pull"),
            ?zInfo("Update done.", Context);
        false ->
            ?zInfo("Doing checkout in: " ++ RootDir, Context),
            os:cmd("cd " ++ z_utils:os_escape(RootDir) ++ " && git clone git://github.com/zotonic/zotonic.git"),
            ?zInfo("Checkout done.", Context)
    end.

make_html(RootDir, Context) ->
    os:cmd("cd " ++ z_utils:os_escape(filename:join(RootDir, "zotonic/doc")) ++ " && make clean stubs production-html"),
    ?zInfo("sphinx docs built.", Context).

make_edocs(RootDir, Context) ->
    os:cmd("cd " ++ z_utils:os_escape(filename:join(RootDir, "zotonic")) ++ " && make edocs"),
    ?zInfo("edocs built.", Context).
