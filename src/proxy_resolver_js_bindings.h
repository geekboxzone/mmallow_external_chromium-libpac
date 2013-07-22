// Copyright (c) 2010 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef NET_PROXY_PROXY_RESOLVER_JS_BINDINGS_H_
#define NET_PROXY_PROXY_RESOLVER_JS_BINDINGS_H_
#pragma once

#include <string>


namespace net {

class HostResolver;
class NetLog;

// Interface for the javascript bindings.
class ProxyResolverJSBindings {
 public:
  ProxyResolverJSBindings() {}// : current_request_context_(NULL) {}

  virtual ~ProxyResolverJSBindings() {}

  // Handler for "alert(message)"
  virtual void Alert(const std::wstring& message) = 0;

  // Handler for "myIpAddress()". Returns true on success and fills
  // |*first_ip_address| with the result.
  virtual bool MyIpAddress(std::string* first_ip_address) = 0;

  // Handler for "myIpAddressEx()". Returns true on success and fills
  // |*ip_address_list| with the result.
  //
  // This is a Microsoft extension to PAC for IPv6, see:
  // http://blogs.msdn.com/b/wndp/archive/2006/07/13/ipv6-pac-extensions-v0-9.aspx

  virtual bool MyIpAddressEx(std::string* ip_address_list) = 0;

  // Handler for "dnsResolve(host)". Returns true on success and fills
  // |*first_ip_address| with the result.
  virtual bool DnsResolve(const std::string& host,
                          std::string* first_ip_address) = 0;

  // Handler for "dnsResolveEx(host)". Returns true on success and fills
  // |*ip_address_list| with the result.
  //
  // This is a Microsoft extension to PAC for IPv6, see:
  // http://blogs.msdn.com/b/wndp/archive/2006/07/13/ipv6-pac-extensions-v0-9.aspx
  virtual bool DnsResolveEx(const std::string& host,
                            std::string* ip_address_list) = 0;

  // Handler for when an error is encountered. |line_number| may be -1
  // if a line number is not applicable to this error.
  virtual void OnError(int line_number, const std::wstring& error) = 0;

  // Creates a default javascript bindings implementation that will:
  //   - Send script error messages to both VLOG(1) and the NetLog.
  //   - Send script alert()s to both VLOG(1) and the NetLog.
  //   - Use the provided host resolver to service dnsResolve().
  //
  // Note that |host_resolver| will be used in sync mode mode.
  static ProxyResolverJSBindings* CreateDefault();

 private:
};

}  // namespace net

#endif  // NET_PROXY_PROXY_RESOLVER_JS_BINDINGS_H_
