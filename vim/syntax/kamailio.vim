" Vim syntax file
" Language:	Kamailio SIP server configuration

if exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Top-level statements
syn match   kamailioConfigParamLine   '^[^=]\+=.*$' contains=kamailioCoreParameter,kamailioCoreValue,kamailioString,kamailioSpecial,kamailioNumber,@kamailioComments
syn region  kamailioConfigModparam    start='^\s*modparamx\=\s*(' end=')' contains=kamailioString,kamailioNumber
syn match   kamailioConfigModule      '^\s*loadmodulex\=\s*"[^"]\+"' contains=kamailioString
syn region  kamailioConfigModuleParam start='^\s*loadmodulex\=\s*(' end=')' contains=kamailioString
syn match   kamailioConfigFlags       '^\s*\(flags\|bool\|avpflags\)\>'

" Comments and pre-processor directives
syn keyword kamailioTodo        TODO FIXME XXX NOTE IMPORTANT contained
syn region  kamailioCppComment  start='/\*' end='\*/' contains=kamailioTodo
syn match   kamailioLineComment '\(#\($\|[^!]\)\|//\).*$' contains=kamailioTodo
syn cluster kamailioComments    contains=kamailioCppComment,kamailioLineComment

syn match   kamailioDefine   '[#!]!\(\(try\)\=def\(ine\)\=\|redef\(ine\)\=\|\(try\)\=undef\(ine\)\=\|ifn\=def\|\(try\)\=defenvs\=\|defexps\=\)\>' nextgroup=kamailioMacro skipwhite
syn match   kamailioPreProc  '[#!]!\(ifexp\|else\|endif\|subst\(defs\=\)\=\|KAMAILIO\|OPENSER\|SER\|MAXCOMPAT\|ALL\)\>'
syn match   kamailioPreProc  '\([#!]!\)\=\<\(include\|import\)_file\>'
syn match   kamailioMacro    '\h\w*' contained

" Literals
syn match   kamailioNumber       '\<\(0x\x\+\|[01]\+b\|\d\+\)\>' contained
syn match   kamailioStringEscape '\\.' contained
syn region  kamailioString       matchgroup=Normal start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=@kamailioStringItems
syn region  kamailioString       matchgroup=Normal start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=@kamailioStringItems
syn cluster kamailioStringItems  contains=kamailioVariable,kamailioVariableGroup,kamailioStringEscape,kamailioSIPMethods,kamailioHTTPMethods,kamailioSIPHeaders

syn keyword kamailioSIPMethods   INVITE ACK BYE CANCEL REGISTER MESSAGE PRACK INFO UPDATE OPTIONS REFER SUBSCRIBE NOTIFY PUBLISH KDMQ contained
syn keyword kamailioHTTPMethods  GET HEAD POST PUT PATCH DELETE contained
syn keyword kamailioSIPHeaders   SIP sip From To CSeq Route Contact Expires Authorization Via contained
syn match   kamailioSIPHeaders   '\<\(Call-Id\|Record-Route\|Content-Length\|Content-Type\|Proxy-Authorization\)\>' contained

" Pseudo-variables and transformations
syn match   kamailioVariable            '\$\h\w*\(([^)]\+)\)\=\|\$?' contained
syn match   kamailioVariableIndex       '\[[0-9+*-]\+\]' contained
syn region  kamailioVariableGroup       matchgroup=Identifier start='\$(\h\w*\(([^)]\+)\)\=' end=')' transparent contained contains=kamailioVariableIndex,kamailioVariable,kamailioVariableGroup,kamailioTransformation
syn match   kamailioTransformationChars '[a-zA-Z_,#;:-]' contained
syn region  kamailioTransformation      matchgroup=Identifier start='{\l\+\.[a-zA-Z0-9_-]\+' end='}' transparent contained contains=kamailioNumber,kamailioVariable,kamailioVariableGroup,kamailioTransformationChars,kamailioTransformation

" Operators
syn match   kamailioOperator      '!\|&&\|||\|=[~=]\=\|>\|<\|+\|-\|/\|\*\||\|&\|\^\|\~' display contained
syn keyword kamailioOperatorWord  defined eq ieq ne ine mod and or not strlen strempty selval contained
syn match   kamailioCast          '(\(int\|str\))' contained

" Statements
syn match   kamailioIdentifier   '\h\w*' contained
syn keyword kamailioConditional  if else switch case default contained
syn keyword kamailioRepeat       while contained
syn keyword kamailioStatement    route break exit return drop contained

" Core keywords, values and functions
syn keyword kamailioSpecial      yes no on off true false enable disable contained
syn match   kamailioSpecial      '\<LOG_\u\+\d\=\>' contained

syn keyword kamailioCoreKeyword  af dst_ip dst_port from_uri method proto status snd_af snd_ip snd_port snd_proto src_ip src_port to_af to_ip to_port to_proto to_uri contained
syn match   kamailioCoreKeyword  '\<\(uri\(:host\|:port\)\=\|msg:len\)\>' contained

syn case ignore
syn keyword kamailioCoreValue    udp tcp tls sctp ws wss inet ipv4 inet6 ipv6 sslv23 sslv2 sslv3 tlsv1 contained
syn case match
syn keyword kamailioCoreValue    max_len myself contained

syn keyword kamailioCoreFunction forward forward_tcp forward_udp forward_tls
      \ forward_sctp log error exec force_rport add_rport local_rport
      \ add_local_rport force_tcp_alias add_tcp_alias udp_mtu
      \ udp_mtu_try_proto setflag resetflag isflagset setavpflag resetavpflag
      \ isavpflagset rewritehost sethost seth rewritehostport sethostport sethp
      \ rewritehostporttrans sethostporttrans sethpt rewriteuser setuser setu
      \ rewriteuserpass setuserpass setup rewriteport setport setp rewriteuri
      \ seturi revert_uri prefix strip strip_tail userphone remove_branch
      \ clear_branches set_advertised_address set_advertised_port
      \ force_send_socket set_forward_no_connect set_reply_no_connect
      \ set_forward_close set_reply_close cfg_select cfg_reset contained

" config parameters (src/core/cfg.lex)
syn keyword kamailioCoreParameter debug fork fork_delay modinit_delay
      \ log_stderror log_facility log_name log_color log_prefix
      \ log_prefix_mode log_engine_type log_engine_data xavp_via_params
      \ xavp_via_fields xavp_via_reply_params listen advertise ADVERTISE
      \ virtual name NAME agname AGNAME vrf VRF alias domain auto_aliases
      \ auto_domains dns rev_dns dns_rev_via dns_try_ipv6 dns_try_naptr
      \ dns_srv_lb dns_srv_loadbalancing dns_udp_pref dns_udp_preference
      \ dns_tcp_pref dns_tcp_preference dns_tls_pref dns_tls_preference
      \ dns_sctp_pref dns_sctp_preference dns_retr_time dns_slow_query_ms
      \ dns_retr_no dns_servers_no dns_use_search_list dns_search_full_match
      \ dns_naptr_ignore_rfc dns_cache_init use_dns_cache dns_use_cache
      \ use_dns_failover dns_use_failover dns_cache_flags
      \ dns_cache_negative_ttl dns_cache_min_ttl dns_cache_max_ttl
      \ dns_cache_mem dns_cache_gc_interval dns_cache_del_nonexp
      \ dns_cache_delete_nonexpired dns_cache_rec_pref dns_cache_mode
      \ auto_bind_ipv6 bind_ipv6_link_local ipv6_hex_style dst_blocklist_init
      \ use_dst_blocklist dst_blocklist_mem dst_blocklist_expire
      \ dst_blocklist_ttl dst_blocklist_gc_interval dst_blocklist_udp_imask
      \ dst_blocklist_tcp_imask dst_blocklist_tls_imask
      \ dst_blocklist_sctp_imask ip_free_bind ipfreebind ip_nonlocal_bind port
      \ statistics stats_name_separator maxbuffer maxsndbuffer sql_buffer_size
      \ msg_clone_extra_size msg_apply_changes_mode msg_recv_max_size
      \ tcp_msg_read_timeout tcp_msg_data_timeout tcp_accept_iplimit
      \ tcp_main_threads tcp_reactor_threads tcp_check_timer children socket
      \ bind workers socket_workers async_workers async_usleep async_nonblock
      \ async_workers_group async_tkv_gname async_tkv_evcb check_via phone2tel
      \ memlog mem_log memdbg mem_dbg mem_summary mem_safety mem_add_size
      \ mem_join mem_status_mode corelog core_log coreparam
      \ sip_parser_log_oneline sip_parser_log sip_parser_mode sip_warning
      \ server_signature server_header user_agent_header reply_to_via user uid
      \ group gid chroot workdir wdir rundir run_dir mhomed disable_tcp
      \ tcp_children tcp_accept_aliases tcp_accept_unique tcp_send_timeout
      \ tcp_connect_timeout tcp_connection_lifetime tcp_connection_match
      \ tcp_poll_method tcp_max_connections tls_max_connections tcp_no_connect
      \ tcp_source_ipv4 tcp_source_ipv6 tcp_fd_cache tcp_buf_write tcp_async
      \ tcp_conn_wq_max tcp_wq_max tcp_rd_buf_size tcp_wq_blk_size
      \ tcp_defer_accept tcp_delayed_ack tcp_syncnt tcp_linger2 tcp_keepalive
      \ tcp_keepidle tcp_keepintvl tcp_keepcnt tcp_crlf_ping
      \ tcp_listen_backlog tcp_accept_no_cl tcp_accept_hep3 tcp_accept_haproxy
      \ tcp_accept_protocols tcp_accept_protos tcp_close_rst tcp_clone_rcvbuf
      \ tcp_reuse_port tcp_wait_data tcp_script_mode
      \ tls_connection_match_domain disable_tls tls_disable enable_tls
      \ tls_enable tls_threads_mode tlslog tls_log tls_port_no tls_method
      \ tls_verify tls_require_certificate tls_certificate tls_private_key
      \ tls_ca_list tls_handshake_timeout tls_send_timeout disable_sctp
      \ enable_sctp sctp_children advertised_address advertised_port
      \ disable_core_dump open_files_limit shm shm_mem shm_mem_size
      \ shm_force_alloc mlock_pages real_time rt_prio rt_policy rt_timer1_prio
      \ rt_fast_timer_prio rt_ftimer_prio rt_timer1_policy rt_ftimer_policy
      \ rt_timer2_prio rt_stimer_prio rt_timer2_policy rt_stimer_policy
      \ mcast_loopback mcast_ttl mcast tos pmtu_discovery exit_timeout
      \ ser_kill_timeout max_while_loops pv_buffer_size pv_buffer_slots
      \ pv_cache_limit pv_cache_action http_reply_hack http_reply_parse
      \ version_table verbose_startup server_id route_locks_size
      \ wait_worker1_mode wait_worker1_time wait_worker1_usleep
      \ received_route_mode max_recursive_level max_branches latency_cfg_log
      \ latency_log latency_limit_db latency_limit_action latency_limit_cfg
      \ rpc_exec_delta rpc_exec_locks rpc_exec_locks_mode uri_host_extra_chars
      \ hdr_name_extra_chars msg_time onsend_route_reply description descr
      \ desc loadpath mpath cfgengine return_mode via_conid_mode
      \ udp_receiver_mode udp4_raw udp4_raw_mtu udp4_raw_ttl udp_accept_proxy contained
" coreparam[...] names (src/core/coreparam.c)
syn keyword kamailioCoreParameter coreparam iuid random_engine timer_sanity_check contained
" pre-rename names of dst_blocklist_*, still common in deployed configs
syn keyword kamailioCoreParameter use_dst_blacklist dst_blacklist_init
      \ dst_blacklist_mem dst_blacklist_expire dst_blacklist_ttl
      \ dst_blacklist_gc_interval contained
syn match   kamailioCoreParameter '\<kemi\.\(event_route\|request_route\|reply_route\|onsend_route\|received_route\|pre_routing\)_callback\>' contained

" Route blocks
syn region  kamailioBlock          start='{' end='}' transparent contained contains=kamailioBlock,@kamailioCodeElements
syn region  kamailioRouteBlockFold matchgroup=kamailioRouteBlock start='\(failure_\|onreply_\|branch_\|event_\|onsend_\|request_\|reply_\)\=route\(\s*\[[^\]]\+\]\)\=\s*\n\={' matchgroup=NONE end='}' fold contains=kamailioBlock,@kamailioCodeElements

syn cluster kamailioCodeElements contains=kamailioDefine,kamailioPreProc,@kamailioComments,kamailioNumber,kamailioString,kamailioVariable,kamailioVariableGroup,kamailioOperator,kamailioOperatorWord,kamailioCast,kamailioConditional,kamailioRepeat,kamailioStatement,kamailioCoreKeyword,kamailioCoreValue,kamailioCoreFunction,kamailioIdentifier

syn sync fromstart

hi def link kamailioCppComment          Comment
hi def link kamailioLineComment         Comment
hi def link kamailioTodo                Todo
hi def link kamailioDefine              Special
hi def link kamailioPreProc             Special
hi def link kamailioMacro               Macro
hi def link kamailioConfigModparam      Function
hi def link kamailioConfigModule        Keyword
hi def link kamailioConfigModuleParam   Keyword
hi def link kamailioConfigFlags         Keyword
hi def link kamailioCoreKeyword         Special
hi def link kamailioCoreValue           Special
hi def link kamailioCoreFunction        Function
hi def link kamailioCoreParameter       Keyword
hi def link kamailioRouteBlock          Type
hi def link kamailioIdentifier          Identifier
hi def link kamailioSpecial             Special
hi def link kamailioOperator            Operator
hi def link kamailioOperatorWord        Operator
hi def link kamailioCast                Type
hi def link kamailioConditional         Conditional
hi def link kamailioRepeat              Repeat
hi def link kamailioStatement           Statement
hi def link kamailioVariable            Identifier
hi def link kamailioVariableIndex       Number
hi def link kamailioTransformationChars Identifier
hi def link kamailioNumber              Number
hi def link kamailioString              String
hi def link kamailioStringEscape        Special
hi def link kamailioSIPMethods          Special
hi def link kamailioHTTPMethods         Special
hi def link kamailioSIPHeaders          Special

let b:current_syntax = "kamailio"

let &cpo = s:cpo_save
unlet s:cpo_save
