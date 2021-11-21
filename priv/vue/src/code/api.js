import axios from 'axios';
axios.defaults.withCredentials = true;

export class API {
  constructor(hostname) {
    this._hostname = hostname;
  }

  fullname(endpoint) {
    return `${this._hostname}/${endpoint}`;
  }

  get(endpoint, config) {
    const url = this.fullname(endpoint);
    return axios.get(url, config);
  }

  post(endpoint, data, config) {
    const url = this.fullname(endpoint);
    return axios.post(url, data, config);
  }
}
