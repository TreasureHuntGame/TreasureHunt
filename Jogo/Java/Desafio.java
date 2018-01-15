public class Desafio {
	private String FLAG;

	public Desafio() {
		for (;;) {
			try {
				Thread.sleep(1000); 
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println("TEXTO");
		}
	}

	public static void main(String[] a) {
		new Desafio();
	}
}
