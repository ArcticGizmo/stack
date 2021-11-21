import { Socket } from 'phoenix';

function create(hostname, channelName, params) {
  const wsHostname = hostname.replace(/^http/, 'ws');
  const socket = new Socket(`${wsHostname}/${channelName}-socket`, { params });

  const channel = socket.channel(channelName, {});

  socket.connect();
  return channel;
}

class PushFailure {
  constructor() {}

  receive(status, callback) {
    if (status === 'error') {
      console.error('[Channel] channel does not exist for push');
      callback({ reason: 'channel does not exist for push' });
    }
  }
}

export default class Channel {
  constructor() {
    this._channel = null;
  }

  destroy() {
    if (!this._channel) {
      return null;
    }

    console.log('[Channel] Destroyed');
    this._channel.leave();
    this._channel.socket.disconnect();
    this._channel = null;
  }

  create(hostname, channelName, params) {
    this.destroy();
    this._channel = create(hostname, channelName, params);
  }

  join() {
    return this._channel.join();
  }

  on(topic, callback) {
    this._channel.on(topic, callback);
  }

  push(event, payload, timeout) {
    if (this._channel) {
      return this._channel.push(event, payload, timeout);
    }
    return new PushFailure();
  }
}
