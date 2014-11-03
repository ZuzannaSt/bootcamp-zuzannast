require "base64"

encoded_data = "
cmVxdWlyZSAiLi9leGFtcGxlLnJiIgpyZXF1aXJlICdtaW5pdGVzdC9hdXRv
cnVuJwpyZXF1aXJlICdmaWxldXRpbHMnCgpJU1NVRSA9IChFTlZbIklTU1VF
Il0gfHwgMTUpLnRvX2kKCmNsYXNzIEFydGljbGVUZXN0IDwgTWluaXRlc3Q6
OlRlc3QKICBkZWYgc2V0dXAKICAgIEBhcnRpY2xlID0gQXJ0aWNsZS5uZXco
J05ldyBPU1gnLCAnU29tZSB0ZXh0IGFib3V0IG5ldyBPU1gnLCAnU3RldmUg
Sm9icycpCiAgZW5kCgogIGlmIElTU1VFID49IDQKICAgIGRlZiB0ZXN0X2dl
dHRlcnNfZGVmaW5lZAogICAgICBhc3NlcnQgQXJ0aWNsZS5pbnN0YW5jZV9t
ZXRob2RzLmluY2x1ZGU/KDp0aXRsZSksICdUaGVyZSBzaG91bGQgYmUgZ2V0
dGVyIGZvciB0aXRsZScKICAgICAgcmVmdXRlIEFydGljbGUuaW5zdGFuY2Vf
bWV0aG9kcy5pbmNsdWRlPyg6dGl0bGU9KSwgJ1RoZXJlIHNob3VsZCBiZSBu
byBzZXR0ZXIgZm9yIHRpdGxlJwoKICAgICAgYXNzZXJ0IEFydGljbGUuaW5z
dGFuY2VfbWV0aG9kcy5pbmNsdWRlPyg6Ym9keSksICdUaGVyZSBzaG91bGQg
YmUgZ2V0dGVyIGZvciBib2R5JwogICAgICByZWZ1dGUgQXJ0aWNsZS5pbnN0
YW5jZV9tZXRob2RzLmluY2x1ZGU/KDpib2R5PSksICdUaGVyZSBzaG91bGQg
YmUgbm8gc2V0dGVyIGZvciBib2R5JwoKICAgICAgYXNzZXJ0IEFydGljbGUu
aW5zdGFuY2VfbWV0aG9kcy5pbmNsdWRlPyg6YXV0aG9yKSwgJ1RoZXJlIHNo
b3VsZCBiZSBnZXR0ZXIgZm9yIGF1dGhvcicKICAgICAgcmVmdXRlIEFydGlj
bGUuaW5zdGFuY2VfbWV0aG9kcy5pbmNsdWRlPyg6YXV0aG9yPSksICdUaGVy
ZSBzaG91bGQgYmUgbm8gc2V0dGVyIGZvciBhdXRob3InCgogICAgICBhc3Nl
cnQgQXJ0aWNsZS5pbnN0YW5jZV9tZXRob2RzLmluY2x1ZGU/KDpjcmVhdGVk
X2F0KSwgJ1RoZXJlIHNob3VsZCBiZSBnZXR0ZXIgZm9yIGNyZWF0ZWRfYXQn
CiAgICAgIHJlZnV0ZSBBcnRpY2xlLmluc3RhbmNlX21ldGhvZHMuaW5jbHVk
ZT8oOmNyZWF0ZWRfYXQ9KSwgJ1RoZXJlIHNob3VsZCBiZSBubyBzZXR0ZXIg
Zm9yIGNyZWF0ZWRfYXQnCiAgICBlbmQKCiAgICBkZWYgdGVzdF9nZXR0ZXJz
X2FuZF9zZXR0ZXJzX2RlZmluZWQKICAgICAgYXNzZXJ0IEFydGljbGUuaW5z
dGFuY2VfbWV0aG9kcy5pbmNsdWRlPyg6bGlrZXMpLCAnVGhlcmUgc2hvdWxk
IGJlIGdldHRlciBmb3IgbGlrZXMnCiAgICAgIGFzc2VydCBBcnRpY2xlLmlu
c3RhbmNlX21ldGhvZHMuaW5jbHVkZT8oOmxpa2VzPSksICdUaGVyZSBzaG91
bGQgYmUgc2V0dGVyIGZvciBsaWtlcycKCiAgICAgIGFzc2VydCBBcnRpY2xl
Lmluc3RhbmNlX21ldGhvZHMuaW5jbHVkZT8oOmRpc2xpa2VzKSwgJ1RoZXJl
IHNob3VsZCBiZSBnZXR0ZXIgZm9yIGRpc2xpa2VzJwogICAgICBhc3NlcnQg
QXJ0aWNsZS5pbnN0YW5jZV9tZXRob2RzLmluY2x1ZGU/KDpkaXNsaWtlcz0p
LCAnVGhlcmUgc2hvdWxkIGJlIHNldHRlciBmb3IgZGlzbGlrZXMnCiAgICBl
bmQKICBlbmQKCiAgaWYgSVNTVUUgPj0gNQogICAgZGVmIHRlc3RfaW5pdGlh
bGl6YXRpb24KICAgICAgYXNzZXJ0X2VxdWFsICdOZXcgT1NYJywgICAgICAg
ICAgICAgICAgIEBhcnRpY2xlLnRpdGxlLCAgICAgJ1RpdGxlIHNob3VsZCBi
ZSBzZXQnCiAgICAgIGFzc2VydF9lcXVhbCAnU3RldmUgSm9icycsICAgICAg
ICAgICAgICBAYXJ0aWNsZS5hdXRob3IsICAgICdBdXRob3Igc2hvdWxkIGJl
IHNldCcKICAgICAgYXNzZXJ0X2VxdWFsICdTb21lIHRleHQgYWJvdXQgbmV3
IE9TWCcsIEBhcnRpY2xlLmJvZHksICAgICAgJ0JvZHkgc2hvdWxkIGJlIHNl
dCcKICAgICAgYXNzZXJ0X2VxdWFsIDAsICAgICAgICAgICAgICAgICAgICAg
ICAgIEBhcnRpY2xlLmxpa2VzLCAgICAgJ0xpa2VzIHBvaW50cyBzaG91bGQg
YmUgc2V0JwogICAgICBhc3NlcnRfZXF1YWwgMCwgICAgICAgICAgICAgICAg
ICAgICAgICAgQGFydGljbGUuZGlzbGlrZXMsICAnRGlzTGlrZXMgcG9pbnRz
IHNob3VsZCBiZSBzZXQnCgogICAgICBhc3NlcnQgIUBhcnRpY2xlLmNyZWF0
ZWRfYXQubmlsPyAsICAgICAgJ2NyZWF0ZWRfYXQgdGltZXN0YW1wIHNob3Vs
ZCBiZSBzZXQnCiAgICAgIGFzc2VydCBAYXJ0aWNsZS5jcmVhdGVkX2F0IDwg
VGltZS5ub3csICAnY3JlYXRlZF9hdCB0aW1lc3RhbXAgc2hvdWxkIGJlIGVh
cmxpZXIgdGhhbiBjdXJyZW50IHRpbWUnCiAgICBlbmQKCiAgICBkZWYgdGVz
dF9pbml0aWFsaXphdGlvbl93aXRoX2Fub255bW91c19hdXRob3IKICAgICAg
YXNzZXJ0X25pbCBBcnRpY2xlLm5ldygnVGl0bGUnLCAnQm9keScpLmF1dGhv
ciwgJ1lvdSBzaG91bGQgYmUgYWJsZSB0byBpbml0aWFsaXplIEFydGljbGUg
d2l0aG91dCBhdXRob3InCiAgICBlbmQKICBlbmQKCiAgaWYgSVNTVUUgPj0g
NgogICAgZGVmIHRlc3RfbGlraW5nCiAgICAgIDMudGltZXN7IEBhcnRpY2xl
Lmxpa2UhIH0KICAgICAgYXNzZXJ0X2VxdWFsIDMsIEBhcnRpY2xlLmxpa2Vz
LCAnVXNpbmcgbGlrZSEgbWV0aG9kIDMgdGltZXMgc2hvdWxkIGluY3JlYXNl
IGxpa2UgcG9pbnRzIG51bWJlciBieSB0aHJlZScKICAgIGVuZAoKICAgIGRl
ZiB0ZXN0X2Rpc2xpa2luZwogICAgICAyLnRpbWVzeyBAYXJ0aWNsZS5kaXNs
aWtlISB9CiAgICAgIGFzc2VydF9lcXVhbCAyLCBAYXJ0aWNsZS5kaXNsaWtl
cywgJ1VzaW5nIGRpc2xpa2UhIG1ldGhvZCAyIHRpbWVzIHNob3VsZCBpbmNy
ZWFzZSBkaXNsaWtlIHBvaW50cyBudW1iZXIgdHdpY2UnCiAgICBlbmQKCiAg
ICBkZWYgdGVzdF9wb2ludHMKICAgICAgYXNzZXJ0X2VxdWFsIDAsIEBhcnRp
Y2xlLnBvaW50cywgJ1BvaW50cyBzaG91bGQgYmUgcmVzZXQgYXQgdGhlIGJl
Z2luaW5nJwoKICAgICAgMS50aW1lc3sgQGFydGljbGUubGlrZSEgfQogICAg
ICBhc3NlcnRfZXF1YWwgMSwgQGFydGljbGUucG9pbnRzLCAnUG9pbnRzIHNo
b3VsZCBpbmNyZWFzZSBhZnRlciB1c2luZyBsaWtlISBvbmNlJwoKICAgICAg
Mi50aW1lc3sgQGFydGljbGUubGlrZSEgfQogICAgICBhc3NlcnRfZXF1YWwg
MywgQGFydGljbGUucG9pbnRzLCAnUG9pbnRzIHNob3VsZCBpbmNyZWFzZSBh
ZnRlciB1c2luZyBsaWtlISBvbmNlIGFuZCB0aGVuIHR3aWNlJwoKICAgICAg
MS50aW1lc3sgQGFydGljbGUuZGlzbGlrZSEgfQogICAgICBhc3NlcnRfZXF1
YWwgMiwgQGFydGljbGUucG9pbnRzLCAnUG9pbnRzIHNob3VsZCBkZWNyZWFz
ZSBhZnRlciB1c2luZyBsaWtlISB0aHJlZSB0aW1lcyBhbmQgdGhlbiBkaXNs
aWtlISBvbmNlJwoKICAgICAgNC50aW1lc3sgQGFydGljbGUuZGlzbGlrZSEg
fQogICAgICBhc3NlcnRfZXF1YWwgLTIsIEBhcnRpY2xlLnBvaW50cywgJ1Bv
aW50cyBzaG91bGQgZGVjcmVhc2UgYWZ0ZXIgdXNpbmcgbGlrZSEgdGhyZWUg
dGltZXMsIGRpc2xpa2UhIG9uY2UgYW5kIHRoZW4gZGlzbGlrZSEgYWdhaW4g
Zm91ciB0aW1lcycKICAgIGVuZAoKICAgIGRlZiB0ZXN0X3ZvdGVzCiAgICAg
IDQudGltZXN7IEBhcnRpY2xlLmRpc2xpa2UhIH0KICAgICAgMy50aW1lc3sg
QGFydGljbGUubGlrZSEgfQoKICAgICAgYXNzZXJ0X2VxdWFsIDcsIEBhcnRp
Y2xlLnZvdGVzLCAnVm90ZXMgc2hvdWxkIGJlIGNhbGN1bGF0ZWQgYnkgYWRk
aW5nIGxpa2UgYW5kIGRpc2xpa2UgcG9pbnRzLiBBdCB0aGlzIGV4YW1wbGUg
bGlrZSEgbWV0aG9kIGlzIHVzZWQgNCB0aW1lcyBhbmQgZGlzbGlrZSEgMyB0
aW1lcycKICAgIGVuZAogIGVuZAoKICBpZiBJU1NVRSA+PSA3CiAgICBkZWYg
dGVzdF9sb25nX2xpbmVzCiAgICAgIGZpcnN0ICAgPSAnMTAwc2lnbnMqKicg
ICogMTAKICAgICAgc2Vjb25kICA9ICcxMHNpZ25zKioqJyAgKiAxCiAgICAg
IHRoaXJkICAgPSAnODFzaWducyoqKicgICogOSArICcqJwogICAgICBib2R5
ID0gW2ZpcnN0LCBzZWNvbmQsIHRoaXJkXS5qb2luKCJcbiIpCgogICAgICBh
c3NlcnRfZXF1YWwgWyIje2ZpcnN0fVxuIiwgdGhpcmRdLCBBcnRpY2xlLm5l
dygnVGl0bGUnLCBib2R5KS5sb25nX2xpbmVzLCAnbG9uZ19saW5lcyBzaG91
bGQgcmV0dXJuIGFsbCBsaW5lcyB3aXRoIG1vcmUgdGhhbiA4MCBzaWducycK
ICAgIGVuZAoKICAgIGRlZiB0ZXN0X3RydW5jYXRlCiAgICAgIGFzc2VydF9l
cXVhbCAnU29tZSB0ZXh0Li4uJywgQGFydGljbGUudHJ1bmNhdGUoMTIpLCAn
TWF4aW11bSBib2R5IGxlbmd0aCBhZnRlciB1c2luZyB0cnVuY2F0ZSBvbiBs
b25nIGJvZHkgc2hvdWxkIGJlIGVxdWFsIHRvIDEyIHNpZ25zJwogICAgZW5k
CgogICAgZGVmIHRlc3RfdHJ1bmNhdGVfd2hlbl9saW1pdF9pc19sb25nZXJf
dGhlbl9ib2R5CiAgICAgIGFzc2VydF9lcXVhbCBAYXJ0aWNsZS5ib2R5LCBA
YXJ0aWNsZS50cnVuY2F0ZSgxMjAwKSwgJ0JvZHkgc2hvdWxkIG5vdCBiZSB0
cnVuY2F0ZWQgd2hlbiBib2R5IGlzIHNob3J0ZXIgdGhhbiBwcm92aWRlZCBs
aW1pdCgxMjAwIHNpZ25zIGluIHRoaXMgZXhhbXBsZSknCiAgICBlbmQKCiAg
ICBkZWYgdGVzdF90cnVuY2F0ZV93aGVuX2xpbWl0X2lzX2Nsb3NlX3RvX2Jv
ZHlfbGVuZ3RoCiAgICAgIGFzc2VydF9lcXVhbCBAYXJ0aWNsZS5ib2R5LCBA
YXJ0aWNsZS50cnVuY2F0ZSgyMyksICdXaGVuIGJvZHkgbGVuZ3RoIGlzIHJl
YWxseSBjbG9zZSB0byBnaXZlbiBsaW1pdCwgaXQgc2hvdWxkIG5vdCBtYWtl
IHRydW5jYXRlIGJ5IGFkZGluZyAoLi4uKSB0byB0aGUgZW5kLiBUaGlzIGV4
YW1wbGUgaGFzIDIzIHNpZ24gbGltaXQgYW5kIGJvZHkgbGVuZ3RoIGlzIGFs
c28gMjMnCiAgICBlbmQKCiAgICBkZWYgdGVzdF9sZW5ndGgKICAgICAgYXNz
ZXJ0X2VxdWFsIDIzLCBAYXJ0aWNsZS5sZW5ndGgsICdsZW5ndGggc2hvdWxk
IHJldHVybiBib2R5IGxlbmd0aCcKICAgIGVuZAoKICAgIGRlZiB0ZXN0X2Nv
bnRhaW4KICAgICBhc3NlcnQgQGFydGljbGUuY29udGFpbj8oJ1NvbWUgdGV4
dCcpLCAgICAgICAgICAgICAgICAgICAgICAgICAnQXJ0aWNsZSBzaG91bGQg
Y29udGFpbiAiU29tZSB0ZXh0IiBzdHJpbmcnCiAgICAgYXNzZXJ0IEBhcnRp
Y2xlLmNvbnRhaW4/KC9PU1gkLyksICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgJ0FydGljbGUgc2hvdWxkIGNvbnRhaW4gL09TWC8gcmVnZXhwJwog
ICAgIGFzc2VydF9lcXVhbCBmYWxzZSwgQGFydGljbGUuY29udGFpbj8oJ1Nv
bWV0aGluZyBkaWZmZXJlbnQnKSwgICdBcnRpY2xlIHNob3VsZCBub3QgY29u
dGFpbiAiU29tZXRoaW5nIGRpZmZlcmVudCIgc3RyaW5nJwogICAgIGFzc2Vy
dF9lcXVhbCBmYWxzZSwgQGFydGljbGUuY29udGFpbj8oJ15PU1gnKSwgICAg
ICAgICAgICAgICAgICdBcnRpY2xlIHNob3VsZCBub3QgY29udGFpbiAvXk9T
WC8gcmVnZXhwJwogICAgZW5kCiAgZW5kCmVuZAoKY2xhc3MgQXJ0aWNsZXNG
aWxlU3lzdGVtVGVzdCA8IE1pbml0ZXN0OjpUZXN0CiAgZGVmIHNldHVwCiAg
ICBGaWxlVXRpbHMubWtkaXJfcCgnYXJ0aWNsZXMnKQogICAgQGZpbGVfc3lz
dGVtID0gQXJ0aWNsZXNGaWxlU3lzdGVtLm5ldygnYXJ0aWNsZXMnKQogIGVu
ZAoKICBkZWYgdGVhcmRvd24KICAgIEZpbGVVdGlscy5ybV9yZignYXJ0aWNs
ZXMnKQogIGVuZAoKICBpZiBJU1NVRSA+PSA5CiAgICBkZWYgdGVzdF9zYXZp
bmcKICAgICAgYXJ0aWNsZSA9IEFydGljbGUubmV3KCdJbmNlcHRpb24nLCAn
TW92aWUgaXMgZ3JlYXQnLCAnTGVvbmFyZG8gRGkgQ2FwcmlvJykKICAgICAg
NC50aW1lc3sgYXJ0aWNsZS5saWtlISB9CgogICAgICBAZmlsZV9zeXN0ZW0u
c2F2ZShbYXJ0aWNsZV0pCgogICAgICBhc3NlcnRfZXF1YWwgJ0xlb25hcmRv
IERpIENhcHJpb3x8NHx8MHx8TW92aWUgaXMgZ3JlYXQnLCBGaWxlLnJlYWQo
J2FydGljbGVzL2luY2VwdGlvbi5hcnRpY2xlJyksICdBcnRpY2xlIHNhdmVk
IHRvIGZpbGUgc2hvdWxkIGhhdmUgcmlnaHQgY29udGVudCcKICAgIGVuZAog
IGVuZAoKICBpZiBJU1NVRSA+PSAxMAogICAgZGVmIHRlc3RfbG9hZGluZwog
ICAgICBGaWxlLm9wZW4oJ2FydGljbGVzL25ld19vc3guYXJ0aWNsZScsICAg
ICAndysnKXsgfGZpbGV8IGZpbGUud3JpdGUgJ1N0ZXZlIEpvYnN8fDEyfHw1
fHxTb21lIHRleHQnIH0KICAgICAgRmlsZS5vcGVuKCdhcnRpY2xlcy9uZXdf
cmFpbHMuYXJ0aWNsZScsICAgJ3crJyl7IHxmaWxlfCBmaWxlLndyaXRlICdE
SEh8fDEwfHwxfHxSYWlscyA0LjAgcmVsZWFzZWQhJyB9CiAgICAgIEZpbGUu
b3BlbignYXJ0aWNsZXMvZGlmZmVyZW50LmV4dGVuc2lvbicsICd3KycpCgog
ICAgICBhcnRpY2xlcyA9IEBmaWxlX3N5c3RlbS5sb2FkLnNvcnRfYnkoJjp0
aXRsZSkKCiAgICAgIGFzc2VydF9lcXVhbCAyLCBhcnRpY2xlcy5zaXplLCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICdJdCBzaG91bGQgbG9hZCAyIGFydGljbGVzJwogICAgICBhc3NlcnRfZXF1
YWwgWydOZXcgb3N4JywgJ05ldyByYWlscyddLCAgICAgICAgICAgICAgYXJ0
aWNsZXMubWFwKCY6dGl0bGUpLCAgICAnTG9hZGVkIGFydGljbGVzIHNob3Vs
ZCBoYXZlIHRoZSByaWdodCB0aXRsZXMnCiAgICAgIGFzc2VydF9lcXVhbCBb
J1N0ZXZlIEpvYnMnLCAnREhIJ10sICAgICAgICAgICAgICAgICBhcnRpY2xl
cy5tYXAoJjphdXRob3IpLCAgICdMb2FkZWQgYXJ0aWNsZXMgc2hvdWxkIGhh
dmUgdGhlIHJpZ2h0IGF1dGhvciBuYW1lcycKICAgICAgYXNzZXJ0X2VxdWFs
IFsnU29tZSB0ZXh0JywgJ1JhaWxzIDQuMCByZWxlYXNlZCEnXSwgIGFydGlj
bGVzLm1hcCgmOmJvZHkpLCAgICAgJ0xvYWRlZCBhcnRpY2xlcyBzaG91bGQg
aGF2ZSB0aGUgcmlnaHQgYm9kaWVzJwogICAgICBhc3NlcnRfZXF1YWwgWzEy
LCAxMF0sICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJ0aWNsZXMu
bWFwKCY6bGlrZXMpLCAgICAnTG9hZGVkIGFydGljbGVzIHNob3VsZCBoYXZl
IHRoZSByaWdodCBsaWtlIHBvaW50cycKICAgICAgYXNzZXJ0X2VxdWFsIFs1
LCAxXSwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFydGljbGVz
Lm1hcCgmOmRpc2xpa2VzKSwgJ0xvYWRlZCBhcnRpY2xlcyBzaG91bGQgaGF2
ZSB0aGUgcmlnaHQgZGlzbGlrZSBwb2ludHMnCiAgICBlbmQKICBlbmQKZW5k
CgpjbGFzcyBXZWJQYWdlVGVzdCA8IE1pbml0ZXN0OjpUZXN0CiAgZGVmIHNl
dHVwCiAgICBGaWxlVXRpbHMubWtkaXIoJ2FydGljbGVzJykKICAgIEZpbGUu
b3BlbignYXJ0aWNsZXMvbmV3X29zeC5hcnRpY2xlJywgICAgICd3KycpeyB8
ZmlsZXwgZmlsZS53cml0ZSAnU3RldmUgSm9ic3x8MTEyfHw1fHxTaG9ydCcg
fQogICAgRmlsZS5vcGVuKCdhcnRpY2xlcy9uZXdfcmFpbHMuYXJ0aWNsZScs
ICAgJ3crJyl7IHxmaWxlfCBmaWxlLndyaXRlICdESEh8fDEwNTB8fDc4fHxS
YWlscyA0LjAgcmVsZWFzZWQhJyB9CiAgICBGaWxlLm9wZW4oJ2FydGljbGVz
L3JhaWxzX2FnYWluLmFydGljbGUnLCAndysnKXsgfGZpbGV8IGZpbGUud3Jp
dGUgJ0RISHx8MTB8fDB8fFJhaWxzIDUuMC4wIHJlbGVhc2VkIScgfQogICAg
RmlsZS5vcGVuKCdhcnRpY2xlcy9zdGFyX3dhcnMuYXJ0aWNsZScsICAgJ3cr
Jyl7IHxmaWxlfCBmaWxlLndyaXRlICdHZW9yZ2UgTHVjYXN8fDUwMDF8fDUw
MDB8fE5ldyBtb3ZpZScgfQoKICAgIEB3ZWJfcGFnZSA9IFdlYlBhZ2UubmV3
KCdhcnRpY2xlcycpCiAgZW5kCgogIGRlZiB0ZWFyZG93bgogICAgRmlsZVV0
aWxzLnJtX3JmKCdhcnRpY2xlcycpCiAgZW5kCgogIGlmIElTU1VFID49IDEx
CiAgICBkZWYgdGVzdF9uZXdfd2l0aG91dF9sb2FkCiAgICAgIGFzc2VydCBX
ZWJQYWdlLm5ldy5hcnRpY2xlcy5lbXB0eT8sICdXZWJQYWdlLm5ldyBzaG91
bGQgbm90IGhhdmUgYW55IGFydGljbGVzJwogICAgZW5kCgogICAgZGVmIHRl
c3RfbmV3X2FydGljbGUKICAgICAgQHdlYl9wYWdlLm5ld19hcnRpY2xlKCdO
ZXcgdGl0bGUnLCAnV2l0aCBuZXcgYm9keScsICdieSBOZXcgQXV0aG9yJykK
ICAgICAgbGFzdF9hcnRpY2xlID0gQHdlYl9wYWdlLmFydGljbGVzLmxhc3QK
CiAgICAgIGFzc2VydF9lcXVhbCAnTmV3IHRpdGxlJywgICAgIGxhc3RfYXJ0
aWNsZS50aXRsZSwgICAnbmV3X2FydGljbGUgbWV0aG9kIHNob3VsZCBjcmVh
dGUgbmV3IGFydGljbGUgd2l0aCBnaXZlbiB0aXRsZScKICAgICAgYXNzZXJ0
X2VxdWFsICdXaXRoIG5ldyBib2R5JywgbGFzdF9hcnRpY2xlLmJvZHksICAg
ICduZXdfYXJ0aWNsZSBtZXRob2Qgc2hvdWxkIGNyZWF0ZSBuZXcgYXJ0aWNs
ZSB3aXRoIGdpdmVuIGJvZHknCiAgICAgIGFzc2VydF9lcXVhbCAnYnkgTmV3
IEF1dGhvcicsIGxhc3RfYXJ0aWNsZS5hdXRob3IsICAnbmV3X2FydGljbGUg
bWV0aG9kIHNob3VsZCBjcmVhdGUgbmV3IGFydGljbGUgd2l0aCBnaXZlbiBh
dXRob3InCiAgICBlbmQKICBlbmQKCiAgaWYgSVNTVUUgPj0gMTIKICAgIGRl
ZiB0ZXN0X2xvbmdlc3RfYXJ0aWNsZQogICAgICBhc3NlcnRfZXF1YWwgWydS
YWlscyBhZ2FpbicsICdOZXcgcmFpbHMnLCAnU3RhciB3YXJzJywgJ05ldyBv
c3gnXSwgQHdlYl9wYWdlLmxvbmdlc3RfYXJ0aWNsZXMubWFwKCY6dGl0bGUp
LCAnbG9uZ2VzdF9hcnRpY2xlcyBzaG91bGQgcmV0dXJuIGFydGljbGVzIHNv
cnRlZCBieSBib2R5IGxlbmd0aCcKICAgIGVuZAoKICAgIGRlZiB0ZXN0X2Jl
c3RfYXJ0aWNsZXMKICAgICAgYXNzZXJ0X2VxdWFsIFsnTmV3IHJhaWxzJywg
J05ldyBvc3gnLCAnUmFpbHMgYWdhaW4nLCAnU3RhciB3YXJzJ10sIEB3ZWJf
cGFnZS5iZXN0X2FydGljbGVzLm1hcCgmOnRpdGxlKSwgJ2Jlc3RfYXJ0aWNs
ZXMgc2hvdWxkIHJldHVybiBhcnRpY2xlcyBzb3J0ZWQgYnkgcG9pbnRzJwog
ICAgZW5kCgogICAgZGVmIHRlc3RfYmVzdF9hcnRpY2xlCiAgICAgIGFzc2Vy
dF9lcXVhbCAnTmV3IHJhaWxzJywgQHdlYl9wYWdlLmJlc3RfYXJ0aWNsZS50
aXRsZSwgJ2Jlc3RfYXJ0aWNsZSBzaG91bGQgcmV0dXJuIGFydGljbGUgd2l0
aCB0aGUgbW9zdCBudW1iZXIgb2YgcG9pbnRzJwogICAgZW5kCgogICAgZGVm
IHRlc3RfYmVzdF9hcnRpY2xlX2V4Y2VwdGlvbl93aGVuX25vX2FydGljbGVz
X2Nhbl9iZV9mb3VuZAogICAgICBhc3NlcnRfcmFpc2VzKFdlYlBhZ2U6Ok5v
QXJ0aWNsZXNGb3VuZCwgJ2Jlc3RfYXJ0aWNsZSBzaG91bGQgcmFpc2UgZXhj
ZXB0aW9uIHdoZW4gbm8gYXJ0aWNsZXMgY291bGQgYmUgZm91bmQnKSB7ICBX
ZWJQYWdlLm5ldy5iZXN0X2FydGljbGUgfQogICAgZW5kCgogICAgZGVmIHRl
c3Rfd29yc3RfYXJ0aWNsZXMKICAgICAgYXNzZXJ0X2VxdWFsIFsnU3RhciB3
YXJzJywgJ1JhaWxzIGFnYWluJywgJ05ldyBvc3gnLCAnTmV3IHJhaWxzJ10s
IEB3ZWJfcGFnZS53b3JzdF9hcnRpY2xlcy5tYXAoJjp0aXRsZSksICd3b3Jz
dF9hcnRpY2xlcyBzaG91bGQgcmV0dXJuIGFydGljbGVzIHNvcnRlZCBieSBw
b2ludHMgZGVzY2VuZGluZycKICAgIGVuZAoKICAgIGRlZiB0ZXN0X3dvcnN0
X2FydGljbGUKICAgICAgYXNzZXJ0X2VxdWFsICdTdGFyIHdhcnMnLCBAd2Vi
X3BhZ2Uud29yc3RfYXJ0aWNsZS50aXRsZSwgJ3dvcnN0X2FydGljbGUgc2hv
dWxkIHJldHVybiBhcnRpY2xlIHdpdGggdGhlIGxlc3MgbnVtYmVyIG9mIHBv
aW50cycKICAgIGVuZAoKICAgIGRlZiB0ZXN0X3dvcnN0X2FydGljbGVfZXhj
ZXB0aW9uX3doZW5fbm9fYXJ0aWNsZXNfY2FuX2JlX2ZvdW5kCiAgICAgIGFz
c2VydF9yYWlzZXMoV2ViUGFnZTo6Tm9BcnRpY2xlc0ZvdW5kLCAnd29yc3Rf
YXJ0aWNsZSBzaG91bGQgcmFpc2UgZXhjZXB0aW9uIHdoZW4gbm8gYXJ0aWNs
ZXMgY291bGQgYmUgZm91bmQnKSB7ICBXZWJQYWdlLm5ldy53b3JzdF9hcnRp
Y2xlIH0KICAgIGVuZAoKICAgIGRlZiB0ZXN0X21vc3RfY29udHJvdmVyc2lh
bF9hcnRpY2xlcwogICAgICBhc3NlcnRfZXF1YWwgWydTdGFyIHdhcnMnLCAn
TmV3IHJhaWxzJywgJ05ldyBvc3gnLCAnUmFpbHMgYWdhaW4nXSwgQHdlYl9w
YWdlLm1vc3RfY29udHJvdmVyc2lhbF9hcnRpY2xlcy5tYXAoJjp0aXRsZSks
ICdtb3N0X2NvbnRyb3ZlcnNpYWxfYXJ0aWNsZXMgc2hvdWxkIHJldHVybiBh
cnRpY2xlcyBzb3J0ZWQgYnkgdm90ZXMnCiAgICBlbmQKICBlbmQKCiAgaWYg
SVNTVUUgPj0gMTMKICAgIGRlZiB0ZXN0X3ZvdGVzCiAgICAgIGFzc2VydF9l
cXVhbCAxMTI1NiwgQHdlYl9wYWdlLnZvdGVzLCAndm90ZXMgbWV0aG9kIHNo
b3VsZCBzdW0gdm90ZXMgZnJvbSBhbGwgYXJ0aWNsZXMnCiAgICBlbmQKCiAg
ICBkZWYgdGVzdF92b3Rlc193aGVuX25vX2FydGljbGVzCiAgICAgIGFzc2Vy
dF9lcXVhbCAwLCBXZWJQYWdlLm5ldy52b3RlcywgJ3ZvdGVzIHNob3VsZCBy
ZXR1cm4gMCB3aGVuIHRoZXJlIGFyZSBubyBhcnRpY2xlcycKICAgIGVuZAoK
ICAgIGRlZiB0ZXN0X2F1dGhvcnMKICAgICAgYXNzZXJ0X2VxdWFsIFsnREhI
JywgJ0dlb3JnZSBMdWNhcycsICdTdGV2ZSBKb2JzJ10sIEB3ZWJfcGFnZS5h
dXRob3JzLnNvcnQsICdhdXRob3JzIHNob3VsZCByZXR1cm4gbGlzdCBvZiBh
dXRob3JzIGZyb20gYWxsIGFydGljbGVzJwogICAgZW5kCgogICAgZGVmIHRl
c3RfYXV0aG9yc19zdGF0aXN0aWNzCiAgICAgIGFzc2VydF9lcXVhbCh7J1N0
ZXZlIEpvYnMnID0+IDEsICdESEgnID0+IDIsICdHZW9yZ2UgTHVjYXMnID0+
IDF9LCBAd2ViX3BhZ2UuYXV0aG9yc19zdGF0aXN0aWNzLCAnYXV0aG9yc19z
dGF0aXN0aWNzIHNob3VsZCByZXR1cm4gaGFzaCB3aXRoIGF1dGhvcnMgYW5k
IG51bWJlcnMgb2YgYXJ0Y2lsZXMgdGhleSBoYXZlIG1hZGUnKQogICAgZW5k
CgogICAgZGVmIHRlc3RfYmVzdF9hdXRob3IKICAgICAgYXNzZXJ0X2VxdWFs
ICdESEgnLCBAd2ViX3BhZ2UuYmVzdF9hdXRob3IsICdiZXN0X2F1dGhvciBz
aG91bGQgcmV0dXJuIGF1dGhvciB3aG8gY3JlYXRlZCB0aGUgbW9zdCBhcnRp
Y2xlcycKICAgIGVuZAogIGVuZAoKICBpZiBJU1NVRSA+PSAxNAogICAgZGVm
IHRlc3Rfc2VhcmNoCiAgICAgIGFzc2VydF9lcXVhbCBbJ05ldyByYWlscycs
ICdSYWlscyBhZ2FpbiddLCBAd2ViX3BhZ2Uuc2VhcmNoKCdSYWlscycpLm1h
cCgmOnRpdGxlKSwgJ3NlYXJjaCB3aXRoICJSYWlscyIgc3RyaW5nIHNob3Vs
ZCByZXR1cm4gYXJ0aWNsZXMgd2l0aCB0aGlzIHdvcmQgaW4gYSBib2R5Jwog
ICAgZW5kCiAgZW5kCmVuZAo=
"
data = Base64.decode64(encoded_data)

eval(data)
