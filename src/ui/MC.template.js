define(['handlebars'], function(Handlebars){ var __TEMPLATE__, TEMPLATE={"notification":{}};

__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  
  return "<i class=\"notification_close\">&times;</i>";
  }

  buffer += "<div class=\"notification_item "
    + escapeExpression(((stack1 = (depth0 && depth0.type)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "_item\">\n	<span>"
    + escapeExpression(((stack1 = (depth0 && depth0.template)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>\n	";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.should_stay), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</div>";
  return buffer;
  };
TEMPLATE.notification.item=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head alert\">"
    + escapeExpression(((stack1 = (depth0 && depth0.title)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n	"
    + escapeExpression(((stack1 = (depth0 && depth0.description)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n</div>";
  return buffer;
  };
TEMPLATE.bubbleAlert=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head suggest\">"
    + escapeExpression(((stack1 = (depth0 && depth0.title)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n	"
    + escapeExpression(((stack1 = (depth0 && depth0.description)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n</div>";
  return buffer;
  };
TEMPLATE.bubbleSuggest=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head\"><i class=\"status-"
    + escapeExpression(((stack1 = (depth0 && depth0.status)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " icon-label\"></i>"
    + escapeExpression(((stack1 = (depth0 && depth0.title)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "-("
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + ")</div>\n<div class=\"bubble-content\">\n	<dl class=\"dl-horizontal\">\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_LAUNCHTIME", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0['launch-time'])),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_AVAILABILITYZONE", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.az)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_INSTANCETYPE", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0['instance-type'])),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n	</dl>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleInstanceInfo=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head\"></i>"
    + escapeExpression(((stack1 = (depth0 && depth0.snapshotId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n	<dl class=\"dl-horizontal\">\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_SNAPSHOTID", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.snapshotId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_START_TIME", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.startTime)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "STATUS", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.status)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_SIZE", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.size)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_ENCRYPTED", {hash:{},data:data}))
    + "</dt>\n		<dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.encrypted)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n	</dl>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleSnapshotInfo=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n    <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_IMAGEOWNERALIAS", {hash:{},data:data}))
    + "</dt> <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.imageOwnerAlias)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n    ";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n    <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_IMAGEOWNERID", {hash:{},data:data}))
    + "</dt> <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.imageOwnerId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n    ";
  return buffer;
  }

  buffer += "<div class=\"bubble-head\">"
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n	<dl class=\"dl-horizontal\">\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_NAME", {hash:{},data:data}))
    + "</dt>            <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_DESCRIPTION", {hash:{},data:data}))
    + "</dt>     <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.description)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_ARCHITECTURE", {hash:{},data:data}))
    + "</dt>    <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.architecture)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_IMAGELOCATION", {hash:{},data:data}))
    + "</dt>   <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.imageLocation)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n\n    ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.imageOwnerAlias), {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n\n    <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_ISPUBLIC", {hash:{},data:data}))
    + "</dt>       <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.isPublic)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_KERNELID", {hash:{},data:data}))
    + "</dt>       <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.kernelId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_ROOTDEVICENAME", {hash:{},data:data}))
    + "</dt> <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.rootDeviceName)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n		<dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_ROOTDEVICETYPE", {hash:{},data:data}))
    + "</dt> <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.rootDeviceType)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n    <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_IMAGE_SIZE", {hash:{},data:data}))
    + "</dt>    <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.imageSize)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n    <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "BUBBLE_INSTANCETYPE", {hash:{},data:data}))
    + "</dt> <dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.instanceType)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n	</dl>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleAMIInfo=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head\">"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n    <dl class=\"dl-horizontal\">\n        <dt>Distro</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>Version</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.os_version)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>"
    + escapeExpression(helpers.i18n.call(depth0, "DASH_BUB_ARCHITECTURE", {hash:{},data:data}))
    + "</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.architecture)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>Volume Size</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.vol_size)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "GB</dd>\n        <dt>id</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>Created</dt><dd>"
    + escapeExpression(helpers.timeStr.call(depth0, (depth0 && depth0.created_at), {hash:{},data:data}))
    + "</dd>\n    </dl>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleOsAmiInfo=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head\">"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"bubble-content\">\n    <dl class=\"dl-horizontal\">\n        <dt>Status</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.status)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>UUID</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>Parent Volume</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.volume_id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</dd>\n        <dt>Volume Size</dt><dd>"
    + escapeExpression(((stack1 = (depth0 && depth0.vol_size)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "GB</dd>\n        <dt>Created</dt><dd>"
    + escapeExpression(helpers.timeStr.call(depth0, (depth0 && depth0.created_at), {hash:{},data:data}))
    + "</dd>\n    </dl>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleOsSnapshotInfo=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n\nIPSec Tunnel #"
    + escapeExpression(((stack1 = (depth0 && depth0.number)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n================================================================================\n#1: Internet Key Exchange Configuration\n\nConfigure the IKE SA as follows\n  - Authentication Method    : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_protocol_method)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Pre-Shared Key           : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_pre_shared_key)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Authentication Algorithm : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_authentication_protocol_algorithm)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Encryption Algorithm     : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_encryption_protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Lifetime                 : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_lifetime)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " seconds\n  - Phase 1 Negotiation Mode : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_mode)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Perfect Forward Secrecy  : "
    + escapeExpression(((stack1 = (depth0 && depth0.ike_perfect_forward_secrecy)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\n#2: IPSec Configuration\n\nConfigure the IPSec SA as follows:\n  - Protocol                 : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Authentication Algorithm : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_authentication_protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Encryption Algorithm     : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_encryption_protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Lifetime                 : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_lifetime)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " seconds\n  - Mode                     : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_mode)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Perfect Forward Secrecy  : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_perfect_forward_secrecy)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nIPSec Dead Peer Detection (DPD) will be enabled on the AWS Endpoint. We\nrecommend configuring DPD on your endpoint as follows:\n  - DPD Interval             : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_interval)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - DPD Retries              : "
    + escapeExpression(((stack1 = (depth0 && depth0.ipsec_retries)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nIPSec ESP (Encapsulating Security Payload) inserts additional\nheaders to transmit packets. These headers require additional space,\nwhich reduces the amount of space available to transmit application data.\nTo limit the impact of this behavior, we recommend the following\nconfiguration on your Customer Gateway:\n  - TCP MSS Adjustment       : "
    + escapeExpression(((stack1 = (depth0 && depth0.tcp_mss_adjustment)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " bytes\n  - Clear Don't Fragment Bit : "
    + escapeExpression(((stack1 = (depth0 && depth0.clear_df_bit)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Fragmentation            : "
    + escapeExpression(((stack1 = (depth0 && depth0.fragmentation_before_encryption)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\n#3: Tunnel Interface Configuration\n\nYour Customer Gateway must be configured with a tunnel interface that is\nassociated with the IPSec tunnel. All traffic transmitted to the tunnel\ninterface is encrypted and transmitted to the Virtual Private Gateway.\n\nThe Customer Gateway and Virtual Private Gateway each have two addresses that relate\nto this IPSec tunnel. Each contains an outside address, upon which encrypted\ntraffic is exchanged. Each also contain an inside address associated with\nthe tunnel interface.\n\nThe Customer Gateway outside IP address was provided when the Customer Gateway\nwas created. Changing the IP address requires the creation of a new\nCustomer Gateway.\n\nThe Customer Gateway inside IP address should be configured on your tunnel\ninterface.\n\nOutside IP Addresses:\n  - Customer Gateway 		        : "
    + escapeExpression(((stack1 = (depth0 && depth0.customer_gateway_outside_address)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Virtual Private Gateway	        : "
    + escapeExpression(((stack1 = (depth0 && depth0.vpn_gateway_outside_address)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nInside IP Addresses\n  - Customer Gateway         		: "
    + escapeExpression(((stack1 = (depth0 && depth0.customer_gateway_inside_address)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Virtual Private Gateway             : "
    + escapeExpression(((stack1 = (depth0 && depth0.vpn_gateway_inside_address)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nConfigure your tunnel to fragment at the optimal size:\n  - Tunnel interface MTU     : 1436 bytes\n\n";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isStaticRouting), {hash:{},inverse:self.program(4, program4, data),fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n";
  return buffer;
  }
function program2(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n#4: Static Routing Configuration:\n\nTo route traffic between your internal network and your VPC,\nyou will need a static route added to your router.\n\nStatic Route Configuration Options:\n\n  - Next hop                      : "
    + escapeExpression(((stack1 = (depth0 && depth0.next_hop)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nYou should add static routes towards your internal network on the VGW.\nThe VGW will then send traffic towards your internal network over\nhe tunnels.\n";
  return buffer;
  }

function program4(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n#4: Border Gateway Protocol (BGP) Configuration:\n\nThe Border Gateway Protocol (BGPv4) is used within the tunnel, between the inside\nIP addresses, to exchange routes from the VPC to your home network. Each\nBGP router has an Autonomous System Number (ASN). Your ASN was provided\nto AWS when the Customer Gateway was created.\n\nBGP Configuration Options:\n  - Customer Gateway ASN	          : "
    + escapeExpression(((stack1 = (depth0 && depth0.customer_gateway_bgp_asn)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Virtual Private  Gateway ASN          : "
    + escapeExpression(((stack1 = (depth0 && depth0.vpn_gateway_bgp_asn)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Neighbor IP Address     		  : "
    + escapeExpression(((stack1 = (depth0 && depth0.neighbor_ip_address)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n  - Neighbor Hold Time       : "
    + escapeExpression(((stack1 = (depth0 && depth0.customer_gateway_bgp_hold_time)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nConfigure BGP to announce routes to the Virtual Private Gateway. The gateway\nwill announce prefixes to your customer gateway based upon the prefix you\nassigned to the VPC at creation time.\n";
  return buffer;
  }

  buffer += "Amazon Web Services\nVirtual Private Cloud\n\nVPN Connection Configuration\n================================================================================\nAWS utilizes unique identifiers to manipulate the configuration of\na VPN Connection. Each VPN Connection is assigned a VPN Connection Identifier\nand is associated with two other identifiers, namely the\nCustomer Gateway Identifier and the Virtual Private Gateway Identifier.\n\nYour VPN Connection ID		         : "
    + escapeExpression(((stack1 = (depth0 && depth0.vpnConnectionId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\nYour Virtual Private Gateway ID          : "
    + escapeExpression(((stack1 = (depth0 && depth0.vpnGatewayId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\nYour Customer Gateway ID    		 : "
    + escapeExpression(((stack1 = (depth0 && depth0.customerGatewayId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\n\nA VPN Connection consists of a pair of IPSec tunnel security associations (SAs).\nIt is important that both tunnel security associations be configured.\n\n";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.tunnel), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n\n\n\nAdditional Notes and Questions\n================================================================================\n\n  - Amazon Virtual Private Cloud Getting Started Guide:\n      http://docs.amazonwebservices.com/AmazonVPC/latest/GettingStartedGuide\n  - Amazon Virtual Private Cloud Network Administrator Guide:\n      http://docs.amazonwebservices.com/AmazonVPC/latest/NetworkAdminGuide\n  - XSL Version: 2009-07-15-1119716";
  return buffer;
  };
TEMPLATE.configurationDownload=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<section id=\"modal-run-mesos\">\n  <div class=\"modal-control-group clearfix\" data-bind=\"true\">\n      <label class=\"label\" for=\"app-name\">Deployment Name</label>\n      <input id=\"app-name\" class=\"input modal-input-value\" type=\"text\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-ignore=\"true\">\n      <div class=\"runtime-error\" id=\"runtime-error-appname\"></div>\n  </div>\n	<div class=\"modal-control-group clearfix\">\n	  <label class=\"label var-label\">Specify the variable value for this deployment:</label>\n	  <ul class=\"para-list\">\n	  	<li class=\"para-item\">\n		  <input class=\"input key\" value=\"$env\" disabled />\n		  <input class=\"input value\" />\n		</li>\n		<li class=\"para-item\">\n		  <input class=\"input key\" value=\"$ver\" disabled />\n		  <input class=\"input value\" />\n	    </li>\n	  </ul>\n	</div>\n  <div class=\"modal-control-group clearfix\" data-bind=\"true\">\n      <label class=\"label url-label\" for=\"app-url\">Specify the URL of your Mesos Cluster’s Master:</label>\n      <input id=\"app-url\" class=\"input\" type=\"text\">\n      <div class=\"runtime-error\" id=\"runtime-error-appurl\"></div>\n  </div>\n  <div class=\"mesos-tip\">You need to have a running Mesos Cluster first, either using VisualOps Mesos Sample Stack or your own deployment.</div>\n</section>";
  return buffer;
  };
TEMPLATE.modalRunMesos=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n            <div class=\"warning-text\">\n                "
    + escapeExpression(helpers.i18n.call(depth0, "PAYMENT_WARNNING_IN_MODAL", ((stack1 = (depth0 && depth0.paymentUpdate)),stack1 == null || stack1 === false ? stack1 : stack1.url), {hash:{},data:data}))
    + "\n            </div>\n        ";
  return buffer;
  }

  buffer += "<section id=\"modal-run-stack\">\n    <div class=\"payment-wrapper\">\n        <div class=\"modal-control-group clearfix\" data-bind=\"true\">\n            <label class=\"label\" for=\"app-name\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.APP_NAME", {hash:{},data:data}))
    + "</label>\n            <input id=\"app-name\" class=\"input modal-input-value\" type=\"text\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-ignore=\"true\">\n            <div class=\"runtime-error\" id=\"runtime-error-appname\"></div>\n        </div>\n        <div class=\"modal-control-group default-kp-group clearfix\" style=\"display:none;\">\n            <label for=\"\">$DefaultKeyPair</label>\n            <div id=\"kp-runtime-placeholder\"></div>\n            <div class=\"runtime-error\" id=\"runtime-error-kp\"></div>\n        </div>\n        <div class=\"modal-control-group app-usage-group clearfix\">\n            <label for=\"\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.APP_USAGE", {hash:{},data:data}))
    + "</label>\n            <div id=\"app-usage-selectbox\" class=\"selectbox\">\n                <div class=\"selection\"><i class=\"icon-app-type-testing\"></i>Testing</div>\n                <ul class=\"dropdown\" tabindex=\"-1\">\n                    <li class=\"selected item\" data-value=\"testing\"><i class=\"icon-app-type-testing\"></i>Testing</li>\n                    <li class=\"item\" data-value=\"development\"><i class=\"icon-app-type-development\"></i>Development</li>\n                    <li class=\"item\" data-value=\"production\"><i class=\"icon-app-type-production\"></i>Production</li>\n                    <li class=\"item\" data-value=\"others\"><i class=\"icon-app-type-others\" data-value=\"testing\"></i>Others</li>\n                    <li class=\"item\" data-value=\"custom\"><i class=\"icon-app-type-custom\" data-value=\"custom\"></i>Custom</li>\n                </ul>\n            </div>\n            <input type=\"text\" class=\"input custom-app-usage\" placeholder=\"custom\" maxlength=\"32\" />\n        </div>\n        <div class=\"stack-validation\">\n            <details open style=\"display:none;\">\n                <summary>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_VALIDATION", {hash:{},data:data}))
    + "<span class=\"nutshell\">:<label></label></span></summary>\n                <div id=\"stack-run-validation-container\"></div>\n            </details>\n            <div class=\"validating\">\n                <div class=\"loading-spinner loading-spinner-small\"></div>\n                <p>"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.VALIDATING_STACK", {hash:{},data:data}))
    + "</p>\n            </div>\n        </div>\n    </div>\n    <div class=\"payment-wrapper-right\">\n        <div class=\"estimate clearfix\">\n            <div class=\"title\">"
    + escapeExpression(helpers.i18n.call(depth0, "ESTIMATED_AWS_COST", {hash:{},data:data}))
    + "</div>\n            <div class=\"price\" id=\"label-total-fee\"><b>$"
    + escapeExpression(((stack1 = (depth0 && depth0.total_fee)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</b> "
    + escapeExpression(helpers.i18n.call(depth0, "PER_MONTH", {hash:{},data:data}))
    + "</div>\n        </div>\n        ";
  stack1 = helpers.ifCond.call(depth0, (depth0 && depth0.paymentState), "pastdue", {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </div>\n</section>\n<section class=\"members-only hide\">\n    "
    + escapeExpression(helpers.i18n.call(depth0, "WAIT_FOR_ADMIN_FINISH_CREDENTIAL", {hash:{},data:data}))
    + "\n</section>\n<section style=\"position: absolute; bottom: 21px; left: 17px;\" class=\"property-content \">\n  <div class=\"dryrun checkbox left\" style=\"margin-top: 0px;\"> <input id=\"ipt-dryrun\" type=\"checkbox\"> <label for=\"ipt-dryrun\"></label> </div>\n  <label for=\"ipt-dryrun\" class=\"left\">Dry Run Mode</label>\n  <i class=\"icon-info tooltip left\" style=\"margin-top:2px;\" data-tooltip=\"Checks whether have the required permissions for every action, without actually operate AWS resources and only check for EC2 resources.\"></i>\n</section>";
  return buffer;
  };
TEMPLATE.modalRunStack=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data,depth1) {
  
  var buffer = "", stack1;
  buffer += "\n";
  stack1 = helpers['if'].call(depth0, (depth1 && depth1.deletable), {hash:{},inverse:self.program(4, program4, data),fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n<div class=\"rule-list-row\">\n	<div class='rule-direction-icon tooltip icon-"
    + escapeExpression(((stack1 = (depth0 && depth0.direction)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "' data-tooltip='";
  stack1 = helpers.ifCond.call(depth0, (depth0 && depth0.direction), "inbound", {hash:{},inverse:self.program(8, program8, data),fn:self.program(6, program6, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "'></div>\n	<div class='rule-reference tooltip truncate' data-tooltip='";
  stack1 = helpers.ifCond.call(depth0, (depth0 && depth0.direction), "inbound", {hash:{},inverse:self.program(12, program12, data),fn:self.program(10, program10, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "'>";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.color), {hash:{},inverse:self.noop,fn:self.program(14, program14, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += escapeExpression(((stack1 = (depth0 && depth0.relation)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n</div>\n<div class=\"rule-list-row\">\n	<div><span class=\"rule-protocol tooltip\" data-tooltip='"
    + escapeExpression(helpers.i18n.call(depth0, "PROP.SG_TIP_PROTOCOL", {hash:{},data:data}))
    + "' >"
    + escapeExpression(((stack1 = (depth0 && depth0.protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span></div>\n	<div class='rule-port tooltip' data-tooltip='"
    + escapeExpression(helpers.i18n.call(depth0, "PROP.SG_TIP_PORT_CODE", {hash:{},data:data}))
    + "'>"
    + escapeExpression(((stack1 = (depth0 && depth0.port)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n</div>\n";
  stack1 = helpers['if'].call(depth0, (depth1 && depth1.deletable), {hash:{},inverse:self.noop,fn:self.program(16, program16, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</li>";
  return buffer;
  }
function program2(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<li data-uid=\""
    + escapeExpression(((stack1 = (depth0 && depth0.ruleSetId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-protocol=\""
    + escapeExpression(((stack1 = (depth0 && depth0.protocol)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-port=\""
    + escapeExpression(((stack1 = (depth0 && depth0.port)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-relation=\""
    + escapeExpression(((stack1 = (depth0 && depth0.relation)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-relationid=\""
    + escapeExpression(((stack1 = (depth0 && depth0.relationId)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" data-direction=\""
    + escapeExpression(((stack1 = (depth0 && depth0.direction)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" class=\"pos-r\">\n";
  return buffer;
  }

function program4(depth0,data) {
  
  
  return "\n<li>\n";
  }

function program6(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.SG_TIP_INBOUND", {hash:{},data:data}));
  }

function program8(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.SG_TIP_OUTBOUND", {hash:{},data:data}));
  }

function program10(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "IDE.POP_SGRULE_LBL_SOURCE", {hash:{},data:data}));
  }

function program12(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "IDE.POP_SGRULE_LBL_DEST", {hash:{},data:data}));
  }

function program14(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "<span class=\"sg-color\" style=\"background-color:"
    + escapeExpression(((stack1 = (depth0 && depth0.color)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"></span>";
  return buffer;
  }

function program16(depth0,data) {
  
  var buffer = "";
  buffer += "<a href=\"#\" class=\"sg-rule-delete icon-remove tooltip rule-remove-icon\" data-tooltip='"
    + escapeExpression(helpers.i18n.call(depth0, "PROP.SG_TIP_REMOVE_RULE", {hash:{},data:data}))
    + "'></a>";
  return buffer;
  }

  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.programWithDepth(1, program1, data, depth0),data:data});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }
  };
TEMPLATE.sgRuleList=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<h3 class=\"truncate\"><span class=\"sg-color sg-color-rule-header\" style=\"background-color:"
    + escapeExpression(((stack1 = (depth0 && depth0.ownerColor)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"></span>"
    + escapeExpression(((stack1 = (depth0 && depth0.ownerName)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</h3>\n<ul class=\"sg-rule-list\">";
  stack1 = ((stack1 = (depth0 && depth0.content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "</ul>\n";
  return buffer;
  }

  stack1 = helpers.each.call(depth0, (depth0 && depth0.groups), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }
  };
TEMPLATE.groupedSgRuleList=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<header class=\"mega-list-wraper-header\"><span class=\"sg-color sg-color-rule-header\" style=\"background-color:"
    + escapeExpression(((stack1 = (depth0 && depth0.ownerColor)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"></span>"
    + escapeExpression(((stack1 = (depth0 && depth0.ownerName)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</header>\n<ul class=\"mega-list-wraper\">\n";
  stack1 = ((stack1 = (depth0 && depth0.content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</ul>";
  return buffer;
  }

  buffer += "<p>"
    + escapeExpression(helpers.i18n.call(depth0, "SG_RULE_WILL_BE_DELETED", {hash:{},data:data}))
    + "</p>\n<article class=\"scroll-wrap delete-sgrule-dialog\">\n<div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n<div class=\"scroll-content\">\n";
  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</div>\n</article>";
  return buffer;
  };
TEMPLATE.groupedSgRuleListDelConfirm=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var stack1, escapeExpression=this.escapeExpression, self=this, functionType="function";

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n<li class=\"input-ip-item\">\n  <div class=\"name tooltip\" data-tooltip=\"";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.autoAssign), {hash:{},inverse:self.program(4, program4, data),fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\">\n    <label class=\"input-ip-wrap\" for=\"propertyIpListItem-"
    + escapeExpression(((stack1 = (data == null || data === false ? data : data.index)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"><span class=\"input-ip-prefix\">"
    + escapeExpression(((stack1 = (depth0 && depth0.prefix)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>\n    <input type=\"text\" class=\"input input-ip\"  id=\"propertyIpListItem-"
    + escapeExpression(((stack1 = (data == null || data === false ? data : data.index)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.suffix)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" ";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.editable), {hash:{},inverse:self.noop,fn:self.program(6, program6, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += " data-ignore=\"true\" data-ignore-regexp=\"^[0-9.x]*$\" data-required=\"true\">\n    </label>\n  </div>\n  <div class=\"input-ip-eip-btn tooltip toggle-eip";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasEip), {hash:{},inverse:self.noop,fn:self.program(8, program8, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\" data-tooltip=\"";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasEip), {hash:{},inverse:self.program(12, program12, data),fn:self.program(10, program10, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\"></div>\n  ";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.unDeletable), {hash:{},inverse:self.noop,fn:self.program(14, program14, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</li>\n";
  return buffer;
  }
function program2(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.INSTANCE_IP_MSG_2", {hash:{},data:data}));
  }

function program4(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.INSTANCE_IP_MSG_1", {hash:{},data:data}));
  }

function program6(depth0,data) {
  
  
  return "disabled=\"disabled\"";
  }

function program8(depth0,data) {
  
  
  return " associated";
  }

function program10(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.INSTANCE_IP_MSG_4", {hash:{},data:data}));
  }

function program12(depth0,data) {
  
  
  return escapeExpression(helpers.i18n.call(depth0, "PROP.INSTANCE_IP_MSG_3", {hash:{},data:data}));
  }

function program14(depth0,data) {
  
  
  return "<div class=\"icon-remove\"></div>";
  }

  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }
  };
TEMPLATE.propertyIpList=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  var buffer = "";
  buffer += "\n		<div class=\"modal-text-minor\" style=\"margin-top:10px;\"><i class=\"icon-inbound\"></i>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_INBOUND", {hash:{},data:data}))
    + "</div>\n	";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "";
  buffer += "\n	<div class=\"radio-group-horizontal\">\n		<div class=\"radio\">\n			<input id=\"radio_inbound\" type=\"radio\" name=\"sg-direction\" checked=\"checked\" value=\"inbound\" />\n			<label for=\"radio_inbound\"></label>\n		</div>\n		<label for=\"radio_inbound\" ><i class=\"icon-inbound icon-label\"></i>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_INBOUND", {hash:{},data:data}))
    + "</label>\n	</div>\n	<div class=\"radio-group-horizontal\">\n		<div class=\"radio\">\n			<input id=\"radio_outbound\" type=\"radio\" name=\"sg-direction\" value=\"outbound\"/>\n			<label for=\"radio_outbound\"></label>\n		</div>\n		<label for=\"radio_outbound\"><i class=\"icon-outbound icon-label\"></i>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_OUTBOUND", {hash:{},data:data}))
    + "</label>\n	</div>\n	";
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n			<li class=\"item truncate\" data-id=\"sg\" data-uid=\""
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"><span class=\"sg-color\" style=\"background-color:"
    + escapeExpression(((stack1 = (depth0 && depth0.color)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"></span>"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</li>\n			";
  return buffer;
  }

function program7(depth0,data) {
  
  
  return "\n				";
  }

function program9(depth0,data) {
  
  var buffer = "";
  buffer += "\n				<li class=\"item\" data-id=\"custom\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_CUSTOM", {hash:{},data:data}))
    + "</li>\n				<li class=\"item\" data-id=\"all\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_ALL", {hash:{},data:data}))
    + "</li>\n				";
  return buffer;
  }

function program11(depth0,data) {
  
  
  return "\n			<div class=\"sg-protocol-option-input\" id=\"sg-protocol-custom\">\n				<input class=\"input\" name=\"protocol-custom-ranged\" placeholder=\"0-255\" data-ignore=\"true\" data-ignore-regexp=\"^[0-9]*$\" data-required=\"true\">\n			</div>\n			<div class=\"sg-protocol-option-input\" id=\"sg-protocol-all\">\n				Port Range:<span>0-65535</span>\n			</div>\n		";
  }

  buffer += "<div class=\"modal-control-group clearfix\" data-bind=\"true\">\n	<label class=\"label-short\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_DIRECTION", {hash:{},data:data}))
    + "</label>\n	<div id=\"sg-modal-direction\">\n	";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isClassic), {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n	</div>\n</div>\n<div class=\"modal-control-group clearfix\">\n	<label class=\"label-short\" for=\"securitygroup-modal-description\" id=\"rule-modal-ip-range\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_SOURCE", {hash:{},data:data}))
    + "</label>\n	<div class=\"selectbox\" id=\"sg-add-model-source-select\">\n		<div class=\"selection\">IP...</div>\n		<ul class=\"dropdown\">\n			<li class=\"item selected\" data-id=\"custom\">IP...</li>\n			";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.sgList), {hash:{},inverse:self.noop,fn:self.program(5, program5, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n		</ul>\n	</div>\n	<input class=\"input\" type=\"text\" id=\"securitygroup-modal-description\" data-ignore=\"true\" data-ignore-regexp=\"^[0-9./]*$\" data-required=\"true\" placeholder='"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PLACEHOLD_SOURCE", {hash:{},data:data}))
    + "'>\n</div>\n<div class=\"modal-control-group clearfix\">\n	<label class=\"label-short\" >"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_LBL_PROTOCOL", {hash:{},data:data}))
    + "</label>\n	<div class=\"modal-protocol-select\">\n		<div class=\"selectbox\" id=\"modal-protocol-select\"  data-protocal-type=\"tcp\">\n			<div class=\"selection\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_TCP", {hash:{},data:data}))
    + "</div>\n			<ul class=\"dropdown\" tabindex=\"-1\">\n				<li class=\"selected item\" data-id=\"tcp\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_TCP", {hash:{},data:data}))
    + "</li>\n				<li class=\"item\" data-id=\"udp\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_UDP", {hash:{},data:data}))
    + "</li>\n				<li class=\"item\" data-id=\"icmp\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PROTOCOL_ICMP", {hash:{},data:data}))
    + "</li>\n				";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isClassic), {hash:{},inverse:self.program(9, program9, data),fn:self.program(7, program7, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n			</ul>\n		</div>\n	</div>\n	<div id=\"sg-protocol-select-result\">\n		<div class=\"sg-protocol-option-input show\" id=\"sg-protocol-tcp\">\n			<input class=\"input\" type=\"text\" placeholder='"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PLACEHOLD_PORT_RANGE", {hash:{},data:data}))
    + "' data-ignore=\"true\" data-ignore-regexp=\"^[0-9-]*$\"  data-required=\"true\"/>\n		</div>\n		<div class=\"sg-protocol-option-input\" id=\"sg-protocol-udp\">\n			<input class=\"input\" type=\"text\" placeholder='"
    + escapeExpression(helpers.i18n.call(depth0, "POP_SGRULE_PLACEHOLD_PORT_RANGE", {hash:{},data:data}))
    + "' data-ignore=\"true\" data-ignore-regexp=\"^[0-9-]*$\" data-required=\"true\"/>\n		</div>\n\n		<div class=\"sg-protocol-option-input\" id=\"sg-protocol-icmp\">\n			<div class=\"selectbox\" id=\"protocol-icmp-main-select\" data-protocal-main=\"0\"  data-protocal-sub=\"-1\">\n			<div class=\"selection\">Echo Reply(0)</div>\n			<div class=\"dropdown scroll-wrap scrollbar-auto-hide context-wrap\" style=\"height:300px;\">\n				<div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n				<ul tabindex=\"-1\" class=\"scroll-content\">\n					<li class=\"item selected\" data-id=\"0\">Echo Reply(0)</li>\n					<li class=\"item\" data-id=\"3\">Destination Unreachable(3) ...</li>\n					<li class=\"item\" data-id=\"4\">Source Quench(4)</li>\n					<li class=\"item\" data-id=\"5\">Redirect Message(5) ...</li>\n					<li class=\"item\" data-id=\"6\">Alternate Host Address(6)</li>\n					<li class=\"item\" data-id=\"8\">Echo Request(8)</li>\n					<li class=\"item\" data-id=\"9\">Router Advertisement(9)</li>\n					<li class=\"item\" data-id=\"10\">Router Solicitation(10)</li>\n					<li class=\"item\" data-id=\"11\">Time Exceeded(11) ...</li>\n					<li class=\"item\" data-id=\"12\">Parameter Problem: Bad IP header(12) ...</li>\n					<li class=\"item\" data-id=\"13\">Timestamp(13)</li>\n					<li class=\"item\" data-id=\"14\">Timestamp Reply(14)</li>\n					<li class=\"item\" data-id=\"15\">Information Request(15)</li>\n					<li class=\"item\" data-id=\"16\">Information Reply(16)</li>\n					<li class=\"item\" data-id=\"17\">Address Mask Request(17)</li>\n					<li class=\"item\" data-id=\"18\">Address Mask Reply(18)</li>\n					<li class=\"item\" data-id=\"30\">Traceroute(30)</li>\n					<li class=\"item\" data-id=\"31\">Datagram Conversion Error(31)</li>\n					<li class=\"item\" data-id=\"32\">Mobile Host Redirect(32)</li>\n					<li class=\"item\" data-id=\"33\">Where Are You(33)</li>\n					<li class=\"item\" data-id=\"34\">Here I Am(34)</li>\n					<li class=\"item\" data-id=\"35\">Mobile Registration Request(35)</li>\n					<li class=\"item\" data-id=\"36\">Mobile Registration Reply(36)</li>\n					<li class=\"item\" data-id=\"37\">Domain Name Request(37)</li>\n					<li class=\"item\" data-id=\"38\">Domain Name Reply(38)</li>\n					<li class=\"item\" data-id=\"39\">SKIP Algorithm Discovery Protocol(39)</li>\n					<li class=\"item\" data-id=\"40\">Photuris Security Failures(40)</li>\n					<li class=\"item\" data-id=\"-1\">All(-1)</li>\n				</ul>\n			</div>\n			</div>\n		</div>\n\n		<div class=\"selectbox protocol-icmp-sub-select\" id=\"protocol-icmp-sub-select-3\">\n			<div class=\"selection\">All(-1)</div>\n			<div class=\"dropdown scroll-wrap scrollbar-auto-hide context-wrap\" style=\"height:300px;\">\n				<div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n				<ul class=\"scroll-content\" tabindex=\"-1\">\n					<li class=\"item selected\" data-id=\"-1\">All(-1)</li>\n					<li class=\"item\" data-id=\"0\">destination network unreachable(0)</li>\n					<li class=\"item\" data-id=\"1\">destination host unreachable(1)</li>\n					<li class=\"item\" data-id=\"2\">destination protocol unreachable(2)</li>\n					<li class=\"item\" data-id=\"3\">destination port unreachable(3)</li>\n					<li class=\"item\" data-id=\"4\">fragmentation required and DF flag set(4)</li>\n					<li class=\"item\" data-id=\"5\">source route failed(5)</li>\n					<li class=\"item\" data-id=\"6\">destination network unknown(6)</li>\n					<li class=\"item\" data-id=\"7\">destination host unknown(7)</li>\n					<li class=\"item\" data-id=\"8\">source host isolated(8)</li>\n					<li class=\"item\" data-id=\"9\">network administratively prohibited(9)</li>\n					<li class=\"item\" data-id=\"10\">host administratively prohibited(10)</li>\n					<li class=\"item\" data-id=\"11\">network unreachable for TOS(11)</li>\n					<li class=\"item\" data-id=\"12\">host unreachable for TOS(12)</li>\n					<li class=\"item\" data-id=\"13\">communication administratively prohibited(13)</li>\n				</ul>\n			</div>\n		</div>\n\n		<div class=\"selectbox protocol-icmp-sub-select\" id=\"protocol-icmp-sub-select-5\">\n			<div class=\"selection\">All(-1)</div>\n			<ul class=\"dropdown\" tabindex=\"-1\">\n				<li class=\"selected item\" data-id=\"-1\">All(-1)</li>\n				<li class=\"item\" data-id=\"0\">redirect datagram for the network(0)</li>\n				<li class=\"item\" data-id=\"1\">redirect datagram for the host(1)</li>\n				<li class=\"item\" data-id=\"2\">redirect datagram for the TOS & network(2)</li>\n				<li class=\"item\" data-id=\"3\">redirect datagram for the TOS & host(3)</li>\n			</ul>\n		</div>\n\n		<div class=\"selectbox protocol-icmp-sub-select\" id=\"protocol-icmp-sub-select-11\">\n			<div class=\"selection\">All(-1)</div>\n			<ul class=\"dropdown\" tabindex=\"-1\">\n				<li class=\"item selected\" data-id=\"-1\">All(-1)</li>\n				<li class=\"item\" data-id=\"0\">TTL expired transit(0)</li>\n				<li class=\"item\" data-id=\"1\">fragmentation reasembly time exceeded(1)</li>\n			</ul>\n		</div>\n\n		<div class=\"selectbox protocol-icmp-sub-select\" id=\"protocol-icmp-sub-select-12\">\n			<div class=\"selection\">All(-1)</div>\n			<ul class=\"dropdown\" role=\"menu\">\n				<li class=\"item selected\" data-id=\"-1\">All(-1)</li>\n				<li class=\"item\" data-id=\"0\">pointer indicates the error(0)</li>\n				<li class=\"item\" data-id=\"1\">missing a required option(1)</li>\n				<li class=\"item\" data-id=\"2\">bad length(2)</li>\n			</ul>\n		</div>\n\n		";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.isClassic), {hash:{},inverse:self.noop,fn:self.program(11, program11, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n	</div>\n</div>";
  return buffer;
  };
TEMPLATE.modalSGRule=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function";


  buffer += "<section class=\"password-hint\">\n	<p class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "INSTANCE_ASSO_WITH_KEYPAIR", {hash:{},data:data}))
    + "<span>"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span></p>\n	<p>"
    + escapeExpression(helpers.i18n.call(depth0, "TO_ACCESS_THIS_INSTANCE_REMOTELY", {hash:{},data:data}))
    + "</p>\n</section>\n<section class=\"import-zone\">\n	<div id='keypair-loading' class=\"loading-spinner\"></div>\n</section>\n<section class=\"decrypt-action\" style=\"display: none;\">\n	<button class=\"btn btn-blue\" id=\"do-kp-decrypt\" disabled>"
    + escapeExpression(helpers.i18n.call(depth0, "DECRYPT_PASSWORD", {hash:{},data:data}))
    + "</button>\n	<input readonly class=\"input\" type=\"text\" id=\"keypair-pwd\" placeholder=\""
    + escapeExpression(helpers.i18n.call(depth0, "DECRYPTED_PASSWORD_WILL_APPEAR_HERE", {hash:{},data:data}))
    + "\">\n	<div class=\"change-pw-recommend icon-info tooltip\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "RECOMMEND_CHANGE_PASSWORD", {hash:{},data:data}))
    + "\" style=\"display: none;\">"
    + escapeExpression(helpers.i18n.call(depth0, "CHANGE_PASSWORD_RECOMMENDATION_FROM_AWS", {hash:{},data:data}))
    + "</div>\n</section>\n<section class=\"no-password\" style=\"display: none;\">\n	<p>\n		"
    + escapeExpression(helpers.i18n.call(depth0, "YOUR_PASSWORD_IS_NOT_READY", {hash:{},data:data}))
    + "\n	</p>\n\n	<p>\n		"
    + escapeExpression(helpers.i18n.call(depth0, "PASSWORD_OF_OWN_AMI", {hash:{},data:data}))
    + "\n	</p>\n</section>";
  return buffer;
  };
TEMPLATE.modalDecryptPassword=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  
  return "class=\"hide\"";
  }

function program3(depth0,data) {
  
  var buffer = "";
  buffer += "\n	<div class=\"keypair-download clearfix modal-control-group\">\n		<p class=\"modal-text-major left\">"
    + escapeExpression(helpers.i18n.call(depth0, "KEY_PAIR_DATA_IS_READY", {hash:{},data:data}))
    + "</p>\n		<a href=\"#\" class=\"btn btn-blue right\" id=\"keypair-kp-download\">"
    + escapeExpression(helpers.i18n.call(depth0, "PROP.LBL_DOWNLOAD", {hash:{},data:data}))
    + "</a>\n	</div>\n	";
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n	<div class=\"keypair-download clearfix modal-control-group\">\n		<p class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "INSTANCE_ASSO_WITH_KP", {hash:{},data:data}))
    + " "
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</p>\n	</div>\n	";
  return buffer;
  }

function program7(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n	<div id=\"keypair-remote\" class=\"modal-control-group clearfix\">\n		<label for=\"keypair-cmd\">"
    + escapeExpression(helpers.i18n.call(depth0, "LBL_REMOTE_ACCESS", {hash:{},data:data}))
    + "</label>\n		<input class=\"input\" id=\"keypair-cmd\" type=\"text\" readonly=\"readonly\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.loginCmd)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n	</div>\n	";
  return buffer;
  }

function program9(depth0,data) {
  
  var buffer = "";
  buffer += "\n	<div class=\"modal-control-group clearfix\">\n		<label style=\"width:100%;\">"
    + escapeExpression(helpers.i18n.call(depth0, "WINDOWS_LOGIN_PASSWORD", {hash:{},data:data}))
    + "</label>\n		<div id=\"keypair-login\">\n			<input type=\"password\" readonly=\"readonly\" id=\"keypair-pwd-old\" class=\"input\">\n			<a href=\"#\" class=\"btn btn-silver kp-copy-btn\" id=\"keypair-show\">"
    + escapeExpression(helpers.i18n.call(depth0, "SHOW_PASSWORD", {hash:{},data:data}))
    + "</a>\n		</div>\n		<div id=\"keypair-no-pwd\"></div>\n	</div>\n	";
  return buffer;
  }

  buffer += "<section id=\"keypair-body\" ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isOldKp), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += ">\n	";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isOldKp), {hash:{},inverse:self.program(5, program5, data),fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n	";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.windows), {hash:{},inverse:self.program(9, program9, data),fn:self.program(7, program7, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n\n</section>";
  return buffer;
  };
TEMPLATE.modalDownloadKP=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<article>\n	<div class=\"property-control-group\">"
    + escapeExpression(helpers.i18n.call(depth0, "MISSING_PROPERTY_PANEL", {hash:{},data:data}))
    + "</div>\n</article>";
  return buffer;
  };
TEMPLATE.missingPropertyPanel=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<article>\n	<div class=\"property-control-group\">"
    + escapeExpression(((stack1 = (depth0 && depth0.asgName)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + " "
    + escapeExpression(helpers.i18n.call(depth0, "ASG_DELETED_IN_STOPPED_APP", {hash:{},data:data}))
    + "</div>\n</article>";
  return buffer;
  };
TEMPLATE.missingAsgWhenStop=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"modal-text-wraper\"> <div class=\"modal-center-align-helper\">\n	<div class=\"modal-text-major\">"
    + escapeExpression(((stack1 = (depth0 && depth0.main_content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n	<div class=\"modal-text-minor\">"
    + escapeExpression(((stack1 = (depth0 && depth0.desc_content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n</div> </div>";
  return buffer;
  };
TEMPLATE.setupCIDRConfirm=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"modal-body\">\n	<div class=\"modal-center-align-helper\">\n		<p>"
    + escapeExpression(((stack1 = (depth0 && depth0.host)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + escapeExpression(helpers.i18n.call(depth0, "HOST_HAS_BEEN_ASSIGNED_PUBLIC_IP", {hash:{},data:data}))
    + "</p>\n		<p>"
    + escapeExpression(helpers.i18n.call(depth0, "PUBLIC_IP_MUST_BE_REMOVED", (depth0 && depth0.host), {hash:{},data:data}))
    + "</p>\n		<p>"
    + escapeExpression(helpers.i18n.call(depth0, "CONFIRM_REMOVE_PUBLIC_IP", (depth0 && depth0.eni), (depth0 && depth0.host), {hash:{},data:data}))
    + "</p>\n	</div>\n</div>";
  return buffer;
  };
TEMPLATE.modalAttachingEni=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"modal-text-wraper\">\n	 <div class=\"modal-center-align-helper\">\n		<div class=\"modal-text-major\">"
    + escapeExpression(((stack1 = (depth0 && depth0.main_content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n		<div class=\"modal-text-minor\">"
    + escapeExpression(((stack1 = (depth0 && depth0.desc_content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n	</div>\n </div>";
  return buffer;
  };
TEMPLATE.modalDeleteSGOrACL=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<div id=\"loading-modal-wrap\">\n	<div class=\"loading-modal\" id=\"modal-box\">\n		<div class=\"loading-spinner loading-spinner-mid\"></div>\n		<div>"
    + escapeExpression(helpers.i18n.call(depth0, "REFRESHING_RESOURCES", {hash:{},data:data}))
    + "</div>\n	</div>\n</div>";
  return buffer;
  };
TEMPLATE.loadingTransparent=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  var buffer = "";
  buffer += "\n                    <h3 class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_MAJOR_TEXT_RUNNING", {hash:{},data:data}))
    + "</h3>\n                ";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "";
  buffer += "\n                    <h3 class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_MAJOR_TEXT_STOPPED", {hash:{},data:data}))
    + "</h3>\n                    <p class=\"modal-text-minor\" style=\"margin-top:10px;\">"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_MINOR_TEXT_STOPPED", {hash:{},data:data}))
    + "</p>\n                ";
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n                    <ul class=\"error-message-wrapper\">\n                        ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.notification), {hash:{},inverse:self.noop,fn:self.program(6, program6, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                    </ul>\n                ";
  return buffer;
  }
function program6(depth0,data) {
  
  var buffer = "";
  buffer += "\n                            <li class=\"error-message\">"
    + escapeExpression((typeof depth0 === functionType ? depth0.apply(depth0) : depth0))
    + "</li>\n                        ";
  return buffer;
  }

function program8(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n                    <section class=\"mgt10 checkbox-wrap\">\n                        <div class=\"checkbox\">\n                            <input id=\"take-rds-snapshot\" type=\"checkbox\" checked=\"checked\" name=\"dns-resolution\">\n                            <label for=\"take-rds-snapshot\"></label>\n                        </div>\n                        <label for=\"take-rds-snapshot\">"
    + escapeExpression(helpers.i18n.call(depth0, "TAKE_FINAL_SNAPSHOT_FOR_DB_INSTANCES", {hash:{},data:data}))
    + "</label>\n                    </section>\n                    ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.notReadyDB)),stack1 == null || stack1 === false ? stack1 : stack1.length), {hash:{},inverse:self.noop,fn:self.program(9, program9, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                ";
  return buffer;
  }
function program9(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n                        <p class=\"cant-snapshot\">"
    + escapeExpression(helpers.i18n.call(depth0, "DB_INSTANCE", {hash:{},data:data}))
    + "\n                            ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.notReadyDB), {hash:{},inverse:self.noop,fn:self.program(10, program10, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                            "
    + escapeExpression(helpers.i18n.call(depth0, "CANNOT_TAKE_FINAL_SNAPSHOT", {hash:{},data:data}))
    + "</p>\n                    ";
  return buffer;
  }
function program10(depth0,data) {
  
  var buffer = "", stack1;
  stack1 = helpers['if'].call(depth0, (data == null || data === false ? data : data.index), {hash:{},inverse:self.noop,fn:self.program(11, program11, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.attributes)),stack1 == null || stack1 === false ? stack1 : stack1.DBInstanceIdentifier)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "(<span\n                                    class=\"db-stop-status\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.attributes)),stack1 == null || stack1 === false ? stack1 : stack1.DBInstanceStatus)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>)";
  return buffer;
  }
function program11(depth0,data) {
  
  
  return ", ";
  }

function program13(depth0,data) {
  
  var buffer = "";
  buffer += "\n            <div class=\"payment-warning\">\n                "
    + escapeExpression(helpers.i18n.call(depth0, "PAYMENT_WARNNING_IN_MODAL", (depth0 && depth0['payment-link']), {hash:{},data:data}))
    + "\n            </div>\n        ";
  return buffer;
  }

function program15(depth0,data) {
  
  
  return "\n    <section style=\"position: absolute; bottom: -43px; left: 17px;\" class=\"property-content\">\n      <div class=\"dryrun checkbox left\" style=\"margin-top: 0px;\"> <input id=\"ipt-dryrun\" type=\"checkbox\"> <label for=\"ipt-dryrun\"></label> </div>\n      <label for=\"ipt-dryrun\" class=\"left\">Dry Run Mode</label>\n      <i class=\"icon-info tooltip left\" style=\"margin-top:2px;\" data-tooltip=\"Checks whether have the required permissions for every action, without actually operate AWS resources and only check for EC2 resources.\"></i>\n    </section>\n    ";
  }

  buffer += "<div id=\"app-apply-update\">\n    <div class=\"payment-wrapper\">\n        <div class=\"scroll-wrap\" style=\"max-height:455px;min-height:210px;\">\n            <div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n            <div class=\"scroll-content\">\n                <div class=\"modal-control-group default-kp-group clearfix\" style=\"display:none;\">\n                    <label for=\"kp-runtime-placeholder\">$DefaultKeyPair</label>\n                    <div id=\"kp-runtime-placeholder\"></div>\n                    <div class=\"runtime-error\" id=\"runtime-error-kp\"></div>\n                </div>\n                <div class=\"modal-control-group app-usage-group clearfix update-app\">\n                    <label for=\"\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.APP_USAGE", {hash:{},data:data}))
    + "</label>\n                    <div id=\"app-usage-selectbox\" class=\"selectbox\">\n                        <div class=\"selection\"><i class=\"icon-app-type-testing\"></i>Testing</div>\n                        <ul class=\"dropdown\" tabindex=\"-1\">\n                            <li class=\"selected item\" data-value=\"testing\"><i class=\"icon-app-type-testing\"></i>Testing</li>\n                            <li class=\"item\" data-value=\"development\"><i class=\"icon-app-type-development\"></i>Development</li>\n                            <li class=\"item\" data-value=\"production\"><i class=\"icon-app-type-production\"></i>Production</li>\n                            <li class=\"item\" data-value=\"others\"><i class=\"icon-app-type-others\" data-value=\"testing\"></i>Others</li>\n                            <li class=\"item\" data-value=\"custom\"><i class=\"icon-app-type-custom\" data-value=\"custom\"></i>Custom</li>\n                        </ul>\n                    </div>\n                    <input type=\"text\" class=\"input custom-app-usage\" placeholder=\"custom\" maxlength=\"32\" />\n                </div>\n                ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isRunning), {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                <div id=\"release-eips-placeholder\"></div>\n                <div class=\"scroll-wrap\" style=\"max-height:256px;\">\n                    <div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n                    <div class=\"scroll-content res_diff_tree\" id=\"app-update-summary-table\">\n                    </div>\n                </div>\n                ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.notification), {hash:{},inverse:self.noop,fn:self.program(5, program5, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.removeList)),stack1 == null || stack1 === false ? stack1 : stack1.length), {hash:{},inverse:self.noop,fn:self.program(8, program8, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                <div class=\"stack-validation\">\n                    <details open style=\"display:none;\">\n                        <summary>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_VALIDATION", {hash:{},data:data}))
    + "<span class=\"nutshell\">:<label></label></span></summary>\n                        <div id=\"stack-run-validation-container\"></div>\n                    </details>\n                    <div class=\"validating\">\n                        <div class=\"loading-spinner loading-spinner-small\"></div>\n                        <p>"
    + escapeExpression(helpers.i18n.call(depth0, "POP_CONFIRM_UPDATE_VALIDATING", {hash:{},data:data}))
    + "</p>\n                    </div>\n                </div>\n            </div>\n        </div>\n    </div>\n    <div class=\"payment-wrapper-right\">\n        <div class=\"estimate clearfix\">\n            <div class=\"title\">"
    + escapeExpression(helpers.i18n.call(depth0, "ESTIMATED_AWS_COST", {hash:{},data:data}))
    + "</div>\n            <div class=\"price\" id=\"label-total-fee\"><b>"
    + escapeExpression(helpers.i18n.call(depth0, "MONEY_SYMBOL", {hash:{},data:data}))
    + escapeExpression(((stack1 = (depth0 && depth0.total_fee)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</b>"
    + escapeExpression(helpers.i18n.call(depth0, "PER_MONTH", {hash:{},data:data}))
    + "</div>\n        </div>\n        ";
  stack1 = helpers.ifCond.call(depth0, (depth0 && depth0.paymentState), "past_due", {hash:{},inverse:self.noop,fn:self.program(13, program13, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </div>\n    ";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.fastUpdate), {hash:{},inverse:self.noop,fn:self.program(15, program15, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</div>";
  return buffer;
  };
TEMPLATE.updateApp=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, self=this, functionType="function", escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  stack1 = helpers['if'].call(depth0, (data == null || data === false ? data : data.index), {hash:{},inverse:self.noop,fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "<span class=\"resource-tag\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.attributes)),stack1 == null || stack1 === false ? stack1 : stack1.DBInstanceIdentifier)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>(<span class=\"warning-text\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.attributes)),stack1 == null || stack1 === false ? stack1 : stack1.DBInstanceStatus)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>) ";
  return buffer;
  }
function program2(depth0,data) {
  
  
  return ", ";
  }

  buffer += "<p class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "DB_INSTANCE", {hash:{},data:data}))
    + "\n    ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.data), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    "
    + escapeExpression(helpers.i18n.call(depth0, "CANNOT_BE_MODIFIED_NOW", {hash:{},data:data}))
    + "</p>\n<p>"
    + escapeExpression(helpers.i18n.call(depth0, "WAIT_FOR_DB_THEN_UPDATE", {hash:{},data:data}))
    + "</p>";
  return buffer;
  };
TEMPLATE.cantUpdateApp=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  


  return "<div class=\"loading-spinner\"></div>";
  };
TEMPLATE.loadingSpinner=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div id=\"node-action-wrap\">\n	<div id=\"node-action-state\">\n		<div id=\"node-action-state-btn\">\n			<i id=\"node-state-icon\"></i>\n			<span id=\"node-state-number\">"
    + escapeExpression(((stack1 = (depth0 && depth0.state_num)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>\n		</div>\n		<div class=\"node-action-tooltip\">"
    + escapeExpression(helpers.i18n.call(depth0, "EDIT_STATE", {hash:{},data:data}))
    + "</div>\n	</div>\n</div>";
  return buffer;
  };
TEMPLATE.nodeAction=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<section class=\"instance-sys-log-loading loading-spinner\"></section>\n<div class=\"instance-sys-log-content\">"
    + escapeExpression(((stack1 = (depth0 && depth0.log_content)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n<div class=\"instance-sys-log-info modal-text-minor\">"
    + escapeExpression(helpers.i18n.call(depth0, "SYSTEM_LOG_NOT_READY", {hash:{},data:data}))
    + "</div>";
  return buffer;
  };
TEMPLATE.modalInstanceSysLog=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "CONFIRM_TO_DELETE_XXX", (depth0 && depth0.name), {hash:{},data:data}))
    + "</div>\n<div class=\"modal-text-minor\">"
    + escapeExpression(helpers.i18n.call(depth0, "ONCE_DELETE_STATE_CONF_LOST", (depth0 && depth0.name), {hash:{},data:data}))
    + "</div>";
  return buffer;
  };
TEMPLATE.NodeStateRemoveConfirmation=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"modal-text-major\">"
    + escapeExpression(helpers.i18n.call(depth0, "CONFIRM_TO_DELETE_XXX", (depth0 && depth0.name), {hash:{},data:data}))
    + "</div>\n<div class=\"modal-text-minor\">"
    + escapeExpression(helpers.i18n.call(depth0, "THE_SG_WILL_BE_DELETED", (depth0 && depth0.sg), {hash:{},data:data}))
    + "</div>";
  return buffer;
  };
TEMPLATE.ElbRemoveConfirmation=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"bubble-head\">"
    + escapeExpression(helpers.i18n.call(depth0, "NAT_INSTANCE_MEET_REQ", {hash:{},data:data}))
    + "</div>\n<div class=\"bubble-content\">\n	<ul class=\"bubble-NAT-req-list\">\n        "
    + escapeExpression(helpers.i18n.call(depth0, "NAT_INSTANCE_REQS", {hash:{},data:data}))
    + "\n	</ul>\n</div>";
  return buffer;
  };
TEMPLATE.bubbleNATreq=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var escapeExpression=this.escapeExpression;


  return escapeExpression(helpers.nl2br.call(depth0, (depth0 && depth0.content), {hash:{},data:data}));
  };
TEMPLATE.covertNl2br=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var escapeExpression=this.escapeExpression;


  return escapeExpression(helpers.breaklines.call(depth0, (depth0 && depth0.content), {hash:{},data:data}));
  };
TEMPLATE.convertBreaklines=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  
  return " unread";
  }

function program3(depth0,data) {
  
  var buffer = "";
  buffer += "\n      <i class=\"icon-error\"></i>\n      <div class=\"content\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.NOTI_FAILED", (depth0 && depth0.targetName), (depth0 && depth0.operation), (depth0 && depth0.region), {hash:{},data:data}))
    + "</div>\n    ";
  return buffer;
  }

function program5(depth0,data) {
  
  var buffer = "";
  buffer += "\n      <i class=\"icon-pending\"></i>\n      <div class=\"content\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.NOTI_SENDING", (depth0 && depth0.operation), (depth0 && depth0.targetName), (depth0 && depth0.region), {hash:{},data:data}))
    + "</div>\n    ";
  return buffer;
  }

function program7(depth0,data) {
  
  var buffer = "";
  buffer += "\n      <i class=\"icon-pending\"></i>\n      <div class=\"content\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.NOTI_PROCESSING", (depth0 && depth0.operation), (depth0 && depth0.targetName), (depth0 && depth0.region), {hash:{},data:data}))
    + "</div>\n    ";
  return buffer;
  }

function program9(depth0,data) {
  
  var buffer = "";
  buffer += "\n      <i class=\"icon-success\"></i>\n      <div class=\"content\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.NOTI_SUCCESSFULLY", (depth0 && depth0.targetName), (depth0 && depth0.operation), (depth0 && depth0.region), {hash:{},data:data}))
    + "</div>\n    ";
  return buffer;
  }

function program11(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "<div class=\"notification-details\">"
    + escapeExpression(((stack1 = (depth0 && depth0.error)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>";
  return buffer;
  }

  buffer += "<li class=\"notification-item";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.readed), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\">\n  <div class=\"notification-message\">\n    ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.state)),stack1 == null || stack1 === false ? stack1 : stack1.failed), {hash:{},inverse:self.noop,fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.state)),stack1 == null || stack1 === false ? stack1 : stack1.pending), {hash:{},inverse:self.noop,fn:self.program(5, program5, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.state)),stack1 == null || stack1 === false ? stack1 : stack1.processing), {hash:{},inverse:self.noop,fn:self.program(7, program7, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.state)),stack1 == null || stack1 === false ? stack1 : stack1.completed), {hash:{},inverse:self.noop,fn:self.program(9, program9, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n  </div>\n\n  ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.error), {hash:{},inverse:self.noop,fn:self.program(11, program11, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n\n  <div class=\"notification-duration left\">"
    + escapeExpression(((stack1 = (depth0 && depth0.duration)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n  <div class=\"timestamp\">"
    + escapeExpression(((stack1 = (depth0 && depth0.time)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</div>\n</li>";
  return buffer;
  };
TEMPLATE.headerNotifyItem=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data,depth1) {
  
  var buffer = "", stack1;
  buffer += "\n";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.name), {hash:{},inverse:self.noop,fn:self.programWithDepth(2, program2, data, depth1),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n";
  return buffer;
  }
function program2(depth0,data,depth2) {
  
  var buffer = "", stack1;
  buffer += "\n    <li>\n        <input class=\"tokenName input\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" readonly/>\n        <span class=\"tokenToken click-select truncate tooltip\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "PROP.ELB_TIP_CLICK_TO_SELECT_ALL", {hash:{},data:data}))
    + "\">"
    + escapeExpression(((stack1 = (depth0 && depth0.token)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</span>\n        ";
  stack1 = helpers['if'].call(depth0, (depth2 && depth2.isAdmin), {hash:{},inverse:self.noop,fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </li>\n";
  return buffer;
  }
function program3(depth0,data) {
  
  var buffer = "";
  buffer += "<span class=\"tokenControl\">\n            <button class=\"tooltip icon-edit\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "ACCESS_TOKEN_EDIT_TIP", {hash:{},data:data}))
    + "\"></button>\n            <button class=\"tooltip icon-delete\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "ACCESS_TOKEN_DELETE_TIP", {hash:{},data:data}))
    + "\"></button>\n            <button class=\"btn btn-blue tokenDone\">"
    + escapeExpression(helpers.i18n.call(depth0, "HEAD_BTN_DONE", {hash:{},data:data}))
    + "</button>\n        </span>";
  return buffer;
  }

  stack1 = helpers.each.call(depth0, (depth0 && depth0.tokens), {hash:{},inverse:self.noop,fn:self.programWithDepth(1, program1, data, depth0),data:data});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }
  };
TEMPLATE.accessTokenTable=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "";
  return buffer;
  }

function program3(depth0,data) {
  
  
  return " class=\"modal-wrapper-fix\"";
  }

function program5(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "style=\"width: "
    + escapeExpression(((stack1 = (depth0 && depth0.width)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + ";\"";
  return buffer;
  }

function program7(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n        <div class=\"modal-header\">\n            <h3>"
    + escapeExpression(((stack1 = (depth0 && depth0.title)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</h3>\n            ";
  stack1 = helpers.unless.call(depth0, (depth0 && depth0.hideClose), {hash:{},inverse:self.noop,fn:self.program(8, program8, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n        </div>\n        ";
  return buffer;
  }
function program8(depth0,data) {
  
  
  return "<i class=\"modal-close\">×</i>";
  }

function program10(depth0,data) {
  
  
  return " scroll-wrap scrollbar-auto-hide";
  }

function program12(depth0,data) {
  
  
  return "padding: 0;";
  }

function program14(depth0,data) {
  
  var buffer = "", stack1;
  buffer += " max-height: "
    + escapeExpression(((stack1 = (depth0 && depth0.maxHeight)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1));
  return buffer;
  }

function program16(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n            <div class=\"scrollbar-veritical-wrap\"><div class=\"scrollbar-veritical-thumb\"></div></div>\n                <div class=\"scroll-content\" ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.compact), {hash:{},inverse:self.noop,fn:self.program(17, program17, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += ">\n                    ";
  stack1 = ((stack1 = (depth0 && depth0.template)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                </div>\n            ";
  return buffer;
  }
function program17(depth0,data) {
  
  
  return " style=\"padding: 0;\"";
  }

function program19(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n            ";
  stack1 = ((stack1 = (depth0 && depth0.template)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1);
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n            ";
  return buffer;
  }

function program21(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n        <div class=\"modal-footer\">\n            ";
  stack1 = helpers.unless.call(depth0, ((stack1 = (depth0 && depth0.confirm)),stack1 == null || stack1 === false ? stack1 : stack1.hide), {hash:{},inverse:self.noop,fn:self.program(22, program22, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n            ";
  stack1 = helpers.unless.call(depth0, ((stack1 = (depth0 && depth0.cancel)),stack1 == null || stack1 === false ? stack1 : stack1.hide), {hash:{},inverse:self.noop,fn:self.program(25, program25, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n        </div>\n        ";
  return buffer;
  }
function program22(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "<button class=\"btn modal-confirm btn-"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.confirm)),stack1 == null || stack1 === false ? stack1 : stack1.color)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" ";
  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.confirm)),stack1 == null || stack1 === false ? stack1 : stack1.disabled), {hash:{},inverse:self.noop,fn:self.program(23, program23, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += ">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.confirm)),stack1 == null || stack1 === false ? stack1 : stack1.text)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</button>";
  return buffer;
  }
function program23(depth0,data) {
  
  
  return " disabled ";
  }

function program25(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "<button class=\"btn modal-close btn-"
    + escapeExpression(helpers.or.call(depth0, ((stack1 = (depth0 && depth0.cancel)),stack1 == null || stack1 === false ? stack1 : stack1.color), "silver", {hash:{},data:data}))
    + "\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.cancel)),stack1 == null || stack1 === false ? stack1 : stack1.text)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</button>";
  return buffer;
  }

  buffer += "<div class=\"modal-box "
    + escapeExpression(((stack1 = (depth0 && depth0.mode)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n    <div";
  stack1 = helpers.ifCond.call(depth0, (depth0 && depth0.mode), "panel", {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += " ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.width), {hash:{},inverse:self.noop,fn:self.program(5, program5, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += ">\n        ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasHeader), {hash:{},inverse:self.noop,fn:self.program(7, program7, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n	    <div class=\"modal-body context-wrap";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasScroll), {hash:{},inverse:self.noop,fn:self.program(10, program10, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\" style=\"";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.compact), {hash:{},inverse:self.noop,fn:self.program(12, program12, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.maxHeight), {hash:{},inverse:self.noop,fn:self.program(14, program14, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\" >\n            ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasScroll), {hash:{},inverse:self.program(19, program19, data),fn:self.program(16, program16, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n            </div>\n        ";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.hasFooter), {hash:{},inverse:self.noop,fn:self.program(21, program21, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n    </div>\n</div>";
  return buffer;
  };
TEMPLATE.modalTemplate=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function";


  buffer += "<div class=\"payment-no-card-wrapper\">\n    <div class=\"payment-credit-card\"></div>\n    <p class=\"modal-text-minor payment-text\">"
    + escapeExpression(helpers.i18n.call(depth0, "YOUR_FREE_POINTS_USED_UP", (depth0 && depth0.freePointsPerMonth), {hash:{},data:data}))
    + "</p>\n    <table class=\"table payment-table\">\n        <tbody>\n        <tr>\n            <td>"
    + escapeExpression(helpers.i18n.call(depth0, "INSTANCE_HOURS_PER_MONTH", (depth0 && depth0.freePointsPerMonth), {hash:{},data:data}))
    + "</td>\n            <td class=\"align-right\">"
    + escapeExpression(helpers.i18n.call(depth0, "LALEL_FREE", {hash:{},data:data}))
    + "</td>\n        </tr>\n        <tr>\n            <td>"
    + escapeExpression(helpers.i18n.call(depth0, "INSTANCE_HOURS_CONSUMED_OVER_XXX", (depth0 && depth0.freePointsPerMonth), {hash:{},data:data}))
    + "</td>\n            <td class=\"align-right\"><strong>$0.01</strong>/"
    + escapeExpression(helpers.i18n.call(depth0, "PAYMENT_INSTANT_HOUR", {hash:{},data:data}))
    + "</td>\n        </tr>\n        </tbody>\n    </table>\n    <a href=\"https://www.visualops.io/pricing\" target=\"_blank\">"
    + escapeExpression(helpers.i18n.call(depth0, "PRICING_IN_DETAIL", {hash:{},data:data}))
    + "</a>\n    <div class=\"payment-modal-wrap\">\n        <a href=\""
    + escapeExpression(((stack1 = (depth0 && depth0.url)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" class=\"btn btn-blue btn-xlarge\">"
    + escapeExpression(helpers.i18n.call(depth0, "PROVIDE_BILLING_INFORMATION", {hash:{},data:data}))
    + " <i class=\"icon-caret-right\"></i></a>\n    </div>\n</div>";
  return buffer;
  };
TEMPLATE.providePayment=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function", self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n    <p class=\"modal-text-minor payment-text\">"
    + escapeExpression(helpers.i18n.call(depth0, "FAILED_TO_CHARGE_YOUR_CREDIT_CARD", {hash:{},data:data}))
    + "</p>\n    <div class=\"payment-modal-wrap\">\n        <a href=\""
    + escapeExpression(((stack1 = (depth0 && depth0.url)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\" class=\"btn btn-blue btn-xlarge route\">"
    + escapeExpression(helpers.i18n.call(depth0, "UPDATE_BILLING_INFORMATION", {hash:{},data:data}))
    + " <i class=\"icon-caret-right\"></i></a>\n    </div>\n";
  return buffer;
  }

function program3(depth0,data) {
  
  var buffer = "";
  buffer += "\n    <p class=\"modal-text-minor payment-text\">"
    + escapeExpression(helpers.i18n.call(depth0, "FAILED_TO_CHARGE_YOUR_CREDIT_CARD_MEMBER", {hash:{},data:data}))
    + "</p>\n    <p class=\"modal-text-minor payment-text\">"
    + escapeExpression(helpers.i18n.call(depth0, "WAIT_FOR_ADMIN_UPDATE_PAYMENT_MODAL", {hash:{},data:data}))
    + "</p>\n";
  return buffer;
  }

  buffer += "<div class=\"payment-credit-card payment-failed\"></div>\n";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isAdmin), {hash:{},inverse:self.program(3, program3, data),fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  return buffer;
  };
TEMPLATE.paymentUpdate=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"loading-zone\">\n    <p>"
    + escapeExpression(((stack1 = (depth0 && depth0.tip)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</p>\n    <div class=\"loading-spinner\"></div>\n</div>";
  return buffer;
  };
TEMPLATE.credentialLoading=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, escapeExpression=this.escapeExpression, functionType="function";


  buffer += "<div id=\"CredSetupWrap\">\n    <div id=\"CredSetupMsg\" class=\"cred-setup-msg empty-hide warning-red\"></div>\n    <div class=\"modal-control-group\">\n        <label for=\"CredSetupAlias\">"
    + escapeExpression(helpers.i18n.call(depth0, "CREDENTIAL_ALIAS", {hash:{},data:data}))
    + "</label>\n        <input autocomplete=\"off\" class=\"input\" id=\"CredSetupAlias\" type=\"text\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.alias)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n    </div>\n    <div class=\"modal-control-group\">\n        <i class=\"icon-info icon-label tooltip\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_TIP_CRED_ACCOUNTID", {hash:{},data:data}))
    + "\"></i>\n        <label for=\"CredSetupAccount\">"
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_LABEL_ACCOUNTID", {hash:{},data:data}))
    + "</label>\n        <input autocomplete=\"off\" class=\"input\" id=\"CredSetupAccount\" type=\"text\" value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.awsAccount)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n    </div>\n    <div class=\"modal-control-group\">\n        <i class=\"icon-info icon-label tooltip\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_TIP_CRED_ACCESSKEY", {hash:{},data:data}))
    + "\"></i>\n        <label for=\"CredSetupAccessKey\">"
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_LABEL_ACCESSKEY", {hash:{},data:data}))
    + "</label>\n        <input autocomplete=\"off\" class=\"input\" id=\"CredSetupAccessKey\" type=\"text\" placeholder=\""
    + escapeExpression(((stack1 = (depth0 && depth0.awsAccessKey)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n    </div>\n    <div class=\"modal-control-group\">\n        <i class=\"icon-info icon-label tooltip\" data-tooltip=\""
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_TIP_CRED_SECRETKEY", {hash:{},data:data}))
    + "\"></i>\n        <label for=\"CredSetupSecretKey\">"
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_LABEL_SECRETKEY", {hash:{},data:data}))
    + "</label>\n        <input autocomplete=\"off\" class=\"input\" id=\"CredSetupSecretKey\" type=\"password\" placeholder=\""
    + escapeExpression(((stack1 = (depth0 && depth0.awsSecretKey)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">\n    </div>\n    <p class=\"warning-text\">"
    + escapeExpression(helpers.i18n.call(depth0, "CREDENTIAL_AUTHORIZE_NOTE", {hash:{},data:data}))
    + "</p>\n</div>";
  return buffer;
  };
TEMPLATE.credentialForm=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", escapeExpression=this.escapeExpression;


  buffer += "<div class=\"cred-setup-msg empty-hide warning-red\"></div>\n<div class=\"modal-text-major\">\n	"
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_CRED_UPDATE_CONFIRM_TIT", {hash:{},data:data}))
    + "\n	<p class=\"modal-text-major\">\n		"
    + escapeExpression(helpers.i18n.call(depth0, "SETTINGS_CRED_UPDATE_CONFIRM_TEXT", {hash:{},data:data}))
    + "\n	</p>\n</div>";
  return buffer;
  };
TEMPLATE.updateCredentialConfirm=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, functionType="function", escapeExpression=this.escapeExpression, self=this;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "<li class=\"item\" data-value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\"></i>"
    + escapeExpression(((stack1 = (depth0 && depth0.name)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "</li>";
  return buffer;
  }

function program3(depth0,data) {
  
  
  return "\n<div class=\"modal-control-group clearfix\">\n	<label class=\"label var-label\">Specify the variable value for this deployment:</label>\n	<ul class=\"para-list\">\n		<li class=\"para-item\">\n		<input class=\"input key\" value=\"$env\" disabled />\n		<input class=\"input value\" />\n	</li>\n	<li class=\"para-item\">\n		<input class=\"input key\" value=\"$ver\" disabled />\n		<input class=\"input value\" />\n	</li>\n	</ul>\n</div>\n<div class=\"modal-control-group clearfix\" data-bind=\"true\">\n	<label class=\"label url-label\" for=\"app-url\">Specify the URL of your Mesos Cluster’s Master:</label>\n	<input id=\"app-url\" class=\"input\" type=\"text\">\n	<div class=\"runtime-error\" id=\"runtime-error-appurl\"></div>\n</div>\n";
  }

  buffer += "<div id=\"modal-run-mesos\">\n<section class=\"apply-marathon-stack\">\n	<div class=\"modal-control-group clearfix\">\n  <label class=\"label url-label\">Link to a Marathon stack designed with VisualOps:</label>\n  <div id=\"app-usage-selectbox\" class=\"selectbox\">\n    <div class=\"selection\">Select existing Marathon stack …</div>\n    <ul class=\"dropdown\" tabindex=\"-1\">";
  stack1 = helpers.each.call(depth0, depth0, {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "</ul>\n  </div>\n</div>\n";
  stack1 = helpers['if'].call(depth0, (depth0 && depth0.isApp), {hash:{},inverse:self.noop,fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n</section>\n</div>";
  return buffer;
  };
TEMPLATE.applyMarathonStack=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var buffer = "", stack1, self=this, functionType="function", escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n                        <li class=\"item";
  stack1 = helpers.unless.call(depth0, (data == null || data === false ? data : data.index), {hash:{},inverse:self.noop,fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\" data-value=\""
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "\">"
    + escapeExpression(((stack1 = (depth0 && depth0.alias)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "("
    + escapeExpression(((stack1 = (depth0 && depth0.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + ")</li>\n                    ";
  return buffer;
  }
function program2(depth0,data) {
  
  
  return " selected";
  }

  buffer += "<ul class=\"tabs select-stack-type clearfix\">\n    <li class=\"tab-aws-stack active\">\n        <img src=\"/assets/images/ide/aws_stack.png\" alt=\"\"/>\n        <span class=\"stack-title\">AWS Stack</span>\n    </li>\n    <li class=\"tab-mesos-stack\">\n        <img src=\"/assets/images/ide/mesos_stack.png\" alt=\"\"/>\n        <span class=\"stack-title\">Mesos on AWS VPC</span>\n    </li>\n</ul>\n<div class=\"tabs-content\">\n    <div id=\"tab-aws-stack\">\n        <div class=\"control-group clearfix\">\n            <label>Region</label>\n            <div id=\"create-aws-stack-region\" class=\"selectbox\">\n                <div class=\"selection\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.firstRegion)),stack1 == null || stack1 === false ? stack1 : stack1.alias)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "("
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.firstRegion)),stack1 == null || stack1 === false ? stack1 : stack1.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + ")</div>\n                <ul class=\"dropdown\" tabindex=\"-1\">\n                    ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.awsRegions), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                </ul>\n            </div>\n        </div>\n    </div>\n    <div id=\"tab-mesos-stack\" class=\"hide\">\n        <div class=\"control-group clearfix\">\n            <label for=\"mesos-scale\">Scale</label>\n            <div id=\"mesos-scale\" class=\"selectbox\">\n                <div class=\"selection\">\n                    <div class=\"main truncate\">Small</div>\n                    <div class=\"sub\">5 - 50 instances (1 cpu, 2GB mem)</div>\n                </div>\n                <ul class=\"dropdown\" tabindex=\"-1\">\n                    <li class=\"item selected\" data-value=\"small\" data-tooltip-type=\"html\">\n                        <div class=\"main truncate\">Small</div>\n                        <div class=\"sub\">5 - 50 instances (1 cpu, 2GB mem)</div>\n                    </li>\n                    <li class=\"item\" data-value=\"medium\">\n                        <div class=\"main truncate\">Medium</div>\n                        <div class=\"sub\">50 - 200 instances (2 cpu, 3.75GB mem)</div>\n                    </li>\n                    <li class=\"item\" data-value=\"large\">\n                        <div class=\"main truncate\">Large</div>\n                        <div class=\"sub\">200 - 1000 instances (8 cpu, 15GB mem)</div>\n                    </li>\n                </ul>\n            </div>\n        </div>\n        <div class=\"control-group clearfix\">\n            <label>Region</label>\n            <div id=\"create-mesos-stack-region\" class=\"selectbox\">\n                <div class=\"selection\">"
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.firstRegion)),stack1 == null || stack1 === false ? stack1 : stack1.alias)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + "("
    + escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.firstRegion)),stack1 == null || stack1 === false ? stack1 : stack1.id)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1))
    + ")</div>\n                <ul class=\"dropdown\" tabindex=\"-1\">\n                    ";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.awsRegions), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += "\n                </ul>\n            </div>\n        </div>\n        <div class=\"control-group clearfix\">\n            <label for=\"\">Framework</label>\n            <span>\n                <img class=\"marathon-mark-img\" src=\"/assets/images/ide/marathon.png\" alt=\"\"/> <span>Marathon</span>\n                <label class=\"switch toolbar-visual-ops-switch create-mesos-use-marathon on narrow\">\n                    <span class=\"switch-handle\"></span>\n                </label>\n            </span>\n        </div>\n    </div>\n</div>";
  return buffer;
  };
TEMPLATE.createStack=Handlebars.template(__TEMPLATE__);


__TEMPLATE__ =function (Handlebars,depth0,helpers,partials,data) {
  this.compilerInfo = [4,'>= 1.0.0'];
helpers = this.merge(helpers, Handlebars.helpers); data = data || {};
  var stack1, self=this, functionType="function", escapeExpression=this.escapeExpression;

function program1(depth0,data) {
  
  var buffer = "", stack1;
  buffer += "\n    <section class=\"release-eip checkbox-wrap\">\n        <div class=\"checkbox\">\n            <input type=\"checkbox\" id=\"release-eip-checkbox\" />\n            <label for=\"release-eip-checkbox\"></label>\n        </div>\n        <label class=\"modal-text-minor\" for=\"release-eip-checkbox\">"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.POP_RELEASE_EIP_LABEL", {hash:{},data:data}))
    + "(";
  stack1 = helpers.each.call(depth0, (depth0 && depth0.eipsToRelease), {hash:{},inverse:self.noop,fn:self.program(2, program2, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += ")</label>\n        <p>"
    + escapeExpression(helpers.i18n.call(depth0, "TOOLBAR.POP_RELEASE_EIP_NOTE", {hash:{},data:data}))
    + "</p>\n    </section>\n";
  return buffer;
  }
function program2(depth0,data) {
  
  var buffer = "", stack1;
  stack1 = helpers['if'].call(depth0, (data == null || data === false ? data : data.index), {hash:{},inverse:self.noop,fn:self.program(3, program3, data),data:data});
  if(stack1 || stack1 === 0) { buffer += stack1; }
  buffer += escapeExpression(((stack1 = ((stack1 = (depth0 && depth0.resource)),stack1 == null || stack1 === false ? stack1 : stack1.PublicIp)),typeof stack1 === functionType ? stack1.apply(depth0) : stack1));
  return buffer;
  }
function program3(depth0,data) {
  
  
  return ", ";
  }

  stack1 = helpers['if'].call(depth0, ((stack1 = (depth0 && depth0.eipsToRelease)),stack1 == null || stack1 === false ? stack1 : stack1.length), {hash:{},inverse:self.noop,fn:self.program(1, program1, data),data:data});
  if(stack1 || stack1 === 0) { return stack1; }
  else { return ''; }
  };
TEMPLATE.releaseEipCheck=Handlebars.template(__TEMPLATE__);


return TEMPLATE; });