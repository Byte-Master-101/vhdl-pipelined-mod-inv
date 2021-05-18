# https://bitcoin.stackexchange.com/questions/25024/how-do-you-get-a-bitcoin-public-key-from-a-private-key
import sys, hashlib, codecs

##def modExp(base: int, power: int, mod: int):
##    # Copied from https://github.com/TheAlgorithms/Python/blob/master/maths/modular_exponential.py
##
##    if power < 0:
##        return -1
##    base %= mod
##    result = 1
##    #count = 0
##    while power > 0:
##        if power & 1:
##            result = (result * base) % mod
##        power = power >> 1
##        base = (base * base) % mod
##        #count+=1
##
##    #print("Count ", count)
##    return result

def mod_sub(a, b, p):
    # implement with ADD_UNSIGNED in VHDL: https://www.csee.umbc.edu/portal/help/VHDL/packages/numeric_std.vhd
    return a-b+p if b > a else a-b

def mod_add(a, b, p):
    return a+b if a+b < p else a+b-p

def pEncoder(value):
    for i in range(255, -1, -1):
        if ((1 << i) & value) != 0:
            return i
    return 0

def relativeShift(a, b, t):
    if b > a:
        print("ERROR: a > b. THIS SHOULD NOT HAPPEN")
        quit()
    
    aShift = pEncoder(a)
    bShift = pEncoder(b)
    
    relativeShift = aShift - bShift
    b = b << relativeShift
    
    if(b > a):
        b = b >> 1;
        relativeShift -= 1

    t = t << relativeShift
    
    return b, t

##def ext_gcd(a, p):
##    t, new_t = 0, 1
##    r, new_r = p, a
##    
##    while new_r != 0:
##        quotient = r // new_r
##        t, new_t = new_t, (t - quotient * new_t)
##        r, new_r = new_r, (r - quotient * new_r)
##
##    if r > 1:
##        print("Not invertible")
##        return
##    if t < 0:
##        print("Bruh")
##        t += p
##        
##    print("ModInv", t)
##    return t
##    #print("greatest common divisor:", old_r)
##    #print("quotients by the gcd:", t, s)

iters = 0
def ext_gcd(a, p):
    # -p <= t < p
    # -p <= new_t < p
    
    # 0 <= r < p
    # 0 <= new_r < p

    # print(a > p)
    t, new_t = 0, 1
    r, new_r = p, a

    new_iters = 0
    while new_r != 0:
##        print(f"in_t.sign <= '{'1' if t < 0 else '0'}';\nin_t.magnitude <= \"{abs(t):0>256b}\";\n"+
##              f"in_new_t.sign <= '{'1' if new_t < 0 else '0'}';\nin_new_t.magnitude <= \"{abs(new_t):0>256b}\";\n"+
##              f"in_r <= \"{r:0>256b}\";\nin_new_r <= \"{new_r:0>256b}\";\nwait for period;")
##              .format('1' if t < 0 else '0', abs(t),
##                      '1' if new_t < 0 else '0', abs(new_t),
##                      r, new_r))
        
        shifted_r, shifted_t = relativeShift(r, new_r, new_t)

        updated_t = t - shifted_t
        updated_r = r - shifted_r

        if updated_r > new_r:
            t, new_t = updated_t, new_t
            r, new_r = updated_r, new_r
        else:
            t, new_t = new_t, updated_t
            r, new_r = new_r, updated_r

        
##        print(f"assert (out_t.sign = '{'1' if t < 0 else '0'}' AND out_t.magnitude = \"{abs(t):0>256b}\" AND\n"+
##              f"out_new_t.sign = '{'1' if new_t < 0 else '0'}' AND out_new_t.magnitude = \"{abs(new_t):0>256b}\" AND\n"+
##              f"out_r = \"{r:0>256b}\" AND out_new_r = \"{new_r:0>256b}\")\n\treport \"test failed for input combination 1\" severity error;\n")
##        new_iters+=1
##        quit()
##    global iters
##    iters = max(iters, new_iters)
    #print("Iters:", iters)
    if r > 1:
        print("Not invertible")
        return

    # 0 <= res < p
    res = t+p if t < 0 else t
    
    return res
    #print("greatest common divisor:", old_r)
    #print("quotients by the gcd:", t, s)

def ext_binary_gcd(a,b):
    """Extended binary GCD.
       Given input a, b the function returns d, s, t
       such that gcd(a,b) = d = as + bt."""

    u, v, s, t, r = 1, 0, 0, 1, 0
    print(a, b, u, v, s)
    while (a % 2 == 0) and (b % 2 == 0):
        a, b, r = a//2, b//2, r+1
    alpha, beta = a, b

    while (a % 2 == 0):
        a = a//2
        if (u % 2 == 0) and (v % 2 == 0):
            u, v = u//2, v//2
        else:
            u, v = (u + beta)//2, (v - alpha)//2
    count = 0
    while a != b:
        count+=1
        if (b % 2 == 0):
            b = b//2

            if (s % 2 == 0) and (t % 2 == 0):
                s, t = s//2, t//2
            else:
                s, t = (s + beta)//2, (t - alpha)//2
        elif b < a:
            a, b, u, v, s, t = b, a, s, t, u, v
        else:
            b, s, t = b - a, s - u, t - v
    print("count",count)
    return (2 ** r) * a, s, t

    
def modExp(a, b, power, P):
    actual = pow(a-b, power, P)

    val = mod_sub(a, b, P)
    modinv = ext_gcd(val,P)

    print(f"a <= x\"{val:0>64x}\";\np <= x\"{P:0>64x}\";\nModInv <= x\"{modinv:0>64x}\"\n")
    #print("ModInv:", modinv, "\nactual:", actual, "\nvalue: ", a-b, "\n")

    if(modinv != actual):
        print("ERROR!")
        quit()
    #print("actual={}\ncalculated={}\n".format(actual, R))
    #print("{ ", a, ",", actual, " },")
    return actual

def modExp2(a, power, P):
    return modExp(a%P,0,power,P)

def sk_to_pk(sk):
    """
    Derive the public key of a secret key on the secp256k1 curve.

    Args:
        sk: An integer representing the secret key (also known as secret
          exponent).

    Returns:
        A coordinate (x, y) on the curve repesenting the public key
          for the given secret key.

    Raises:
        ValueError: The secret key is not in the valid range [1,N-1].
    """
    # base point (generator)
    G = (0x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798,
         0x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8)

    # field prime
    P = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F

    # order
    N = (1 << 256) - 0x14551231950B75FC4402DA1732FC9BEBF

    print("P",P)
    print("N",hex(N))
    print("G",G)

    # check if the key is valid
    if not(0 < sk < N):
        msg = "{} is not a valid key (not in range [1, {}])"
        raise ValueError(msg.format(hex(sk), hex(N-1)))

    # addition operation on the elliptic curve
    # see: https://en.wikipedia.org/wiki/Elliptic_curve_point_multiplication#Point_addition
    # note that the coordinates need to be given modulo P and that division is
    # done by computing the multiplicative inverse, which can be done with
    # x^-1 = x^(P-2) mod P using fermat's little theorem (the pow function of
    # python can do this efficiently even for very large P)
    def add(p, q):
        px, py = p
        qx, qy = q
        
        if p == q:
            #print("2*py =", 2*py)
            #print("pow(2*py, P-2, P) =", pow(2 * py, P - 2, P))
            #print()
            lam = (3 * px * px) * modExp2(2 * py, P - 2, P) #pow(2 * py, P - 2, P)
        else:
            lam = (qy - py) *  modExp(qx, px, P - 2, P) #pow(qx - px, P - 2, P)
        rx = lam**2 - px - qx
        ry = lam * (px - rx) - py

        #print("P={}\nQ={}\nR={}\n".format(p, q, (rx % P, ry % P)))
        return rx % P, ry % P

    # compute G * sk with repeated addition
    # by using the binary representation of sk this can be done in 256
    # iterations (double-and-add)
    ret = None
    for i in range(256):
        if sk & (1 << i):
            if ret is None:
                ret = G
            else:
                ret = add(ret, G)
        G = add(G, G)

    return ret

def encodePk(pk, compressed=True):
    x, y = pk
    xh = hex(x)[2:]
    yh = hex(y)[2:]
    if len(xh) % 2 == 1: xh = "0"+xh
    if len(yh) % 2 == 1: yh = "0"+yh

    print(xh)
    res = ""
    if(compressed):
        prefix = "02" if y % 2 == 0 else "03"
        res = prefix + xh
    else:
        res = "04" + xh + yh

    return hexToBytes(res)

def bytesToHex(bytes):
    #return codecs.encode(bytes, 'hex')
    return bytes.hex()

def hexToBytes(hex):
    return codecs.decode(hex, 'hex')

def sha256(bytes):
    return hashlib.sha256(bytes).digest()

def ripemd160(bytes):
    ripemd160 = hashlib.new('ripemd160')
    ripemd160.update(bytes)
    return ripemd160.digest()

def checksum(encrypted_pk):
    return sha256(sha256(encrypted_pk))[:4]

def base58(address_hex):
    alphabet = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
    b58_string = ''
    # Get the number of leading zeros
    leading_zeros = len(address_hex) - len(address_hex.lstrip('0'))
    # Convert hex to decimal
    address_int = int(address_hex, 16)
    # Append digits to the start of string
    while address_int > 0:
        digit = address_int % 58
        digit_char = alphabet[digit]
        b58_string = digit_char + b58_string
        address_int //= 58
    # Add ‘1’ for each 2 leading zeros
    ones = leading_zeros // 2
    for one in range(ones):
        b58_string = '1' + b58_string
    return b58_string

#pk = sk_to_pk(2)
#sk = 0x0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef
#sk=0x18e14a7b6a307f426a94f8114701e7c8e774e7f9a47e2c2035db29a206321725

#sk=0x60cf347dbc59d31c1358c8e5cf5e45b822ab85b79cb32a9f3d98184779a9efc2
if len(sys.argv) != 2:
    print("Usage: python3 {} 0x60cf347dbc59d31c1358c8e5cf5e45b822ab85b79cb32a9f3d98184779a9efc2".format(sys.argv[0]))
    quit()

sk = int(sys.argv[1],0)
pk = sk_to_pk(sk)
print("PK Point:       ", pk)

public_key_compressed = encodePk(pk)
public_key_uncompressed = encodePk(pk, False)
print("Compressed PK:  ", bytesToHex(public_key_compressed))
print("Uncompressed PK:", bytesToHex(public_key_uncompressed))

pk_sha256 = sha256(public_key_compressed)
print("SHA256 of PK:   ", bytesToHex(pk_sha256))

pk_ripemd160 = ripemd160(pk_sha256)
print("RIPEMD160 of PK:", bytesToHex(pk_ripemd160))

encrypted_pk = b"\x00"+pk_ripemd160
print("Encrypted PK:   ", bytesToHex(encrypted_pk))

checksum = checksum(encrypted_pk)
print("PK Checksum:    ", bytesToHex(checksum))

raw_address = encrypted_pk + checksum
print("Raw Address:    ", bytesToHex(raw_address))

base58_address = base58(bytesToHex(raw_address))
print("Base58 Address: ", base58_address)

"""
public_key_bytes = codecs.decode(public_key_uncompressed, 'hex')

sha256_bpk = hashlib.sha256(public_key_bytes)
sha256_bpk_digest = sha256_bpk.digest()

# Run RIPEMD-160 for the SHA-256
ripemd160_bpk = hashlib.new('ripemd160')
ripemd160_bpk.update(sha256_bpk_digest)
ripemd160_bpk_digest = ripemd160_bpk.digest()
ripemd160_bpk_hex = codecs.encode(ripemd160_bpk_digest, 'hex')

"""
