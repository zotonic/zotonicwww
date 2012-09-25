%% @author Arjan Scherpenisse <arjan@scherpenisse.net>
%% @copyright 2012 Arjan Scherpenisse <arjan@scherpenisse.net>
%% Date: 2012-09-25

%% @doc Webhook to rebuild the Zotonic documentation

%% Copyright 2012 Arjan Scherpenisse
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

-module(service_zotonicdocs_make).
-author("Arjan Scherpenisse <arjan@scherpenisse.net>").

-svc_title("Fetch and rebuild Zotonic HTML documentation.").
-svc_needauth(false).

-export([process_post/2]).

-include_lib("zotonic.hrl").

process_post(_ReqData, Context) ->
    OurToken = m_config:get_value(mod_zotonicdocs, webhook_token, Context),
    case z_context:get_q("token", Context) of
        undefined ->
            {error, access_denied, "Missing token"};
        Token ->
            case z_convert:to_binary(Token) =:= OurToken of
                false ->
                    {error, access_denied, "Invalid webhook token"};
                true ->
                    mod_zotonicdocs:make(Context),
                    "Updating documentation."
            end
    end.

