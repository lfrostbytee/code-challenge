import { ethers } from 'ethers';

const TOKEN_CONTRACT = "0xc0ecb8499d8da2771abcbf4091db7f65158f1468";
const ADDRESSES = [
  "0xb5d4f343412dc8efb6ff599d790074d0f1e8d430",
  "0x0020c5222a24e4a96b720c06b803fb8d34adc0af",
  "0xd1d8b2aae2ebb2acf013b803bc3c24ca1303a392",
];

const provider = new ethers.JsonRpcProvider('https://bsc-dataseed.binance.org/');

const findBalance = new ethers.Interface([
    //ABI
  'function balanceOf(address holder) returns (uint)',
]);

Promise.all(
  ADDRESSES.map(async (address) => {
    //Reads from the blockchain and executes smart contracts
    //A call does not require ether and cannot change any states
    const balance = await provider.call({
      to: TOKEN_CONTRACT,
      data: findBalance.encodeFunctionData('balanceOf', [address]),
    });
    const decodedBalance = ethers.formatEther(balance);
    // unsure of how to format
    return `${address} ${decodedBalance}`;
  })
).then((balances) => {
  balances.forEach((str) => {
    console.log(str);
  })
}).catch((error) => {
  console.log(error);
});
