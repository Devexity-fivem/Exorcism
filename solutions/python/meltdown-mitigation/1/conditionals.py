def is_criticality_balanced(temperature, neutrons_emitted):
    produto = temperature * neutrons_emitted
    if temperature < 800 and neutrons_emitted > 500 and produto < 500000:
        return True
    else:
        return False
    
is_criticality_balanced(750, 600)
def reactor_efficiency(voltage, current, theoretical_max_power):
    generated_power = voltage * current 
    eficiencia = (generated_power/theoretical_max_power)*100
    if eficiencia >= 80:
        return "green"
    elif eficiencia < 80 and eficiencia >= 60:
        return "orange"
    elif eficiencia < 60 and eficiencia >= 30:
        return "red"
    else:
        return "black"
reactor_efficiency(200,50,15000)
def fail_safe(temperature, neutrons_produced_per_second, threshold):
    produto = temperature * neutrons_produced_per_second
    limite_inferior = 0.9 * threshold
    limite_superior = 1.1 * threshold
    if produto < limite_inferior:
        return "LOW"
    elif produto <= produto <= limite_superior:
        return "NORMAL"
    else:
        return "DANGER"
fail_safe(1000,30,5000)